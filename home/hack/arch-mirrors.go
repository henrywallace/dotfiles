package main

import (
	"bufio"
	"fmt"
	"log"
	"net"
	"net/http"
	"regexp"
	"sort"
	"strings"
	"sync"
	"syscall"
	"time"
)

var (
	// #Server = http://mirror.math.princeton.edu/pub/archlinux/$repo/os/$arch
	reServerURL = regexp.MustCompile(`#Server = (.*)$`)
	reRepo      = regexp.MustCompile(`\$repo`)
	reArch      = regexp.MustCompile(`\$arch`)

	repos = []string{"core", "community", "extra"}
)

func mirrors() ([]string, error) {
	u := "https://www.archlinux.org/mirrorlist?protocol=https&country=US&use_mirror_status=on"
	resp, err := http.Get(u)
	if err != nil {
		return nil, err
	}
	if resp.StatusCode != 200 {
		return nil, fmt.Errorf("bad response: %d", resp.StatusCode)
	}
	var urls []string
	scanner := bufio.NewScanner(resp.Body)
	for scanner.Scan() {
		line := scanner.Text()
		matches := reServerURL.FindStringSubmatch(line)
		if len(matches) != 2 {
			continue
		}
		urls = append(urls, matches[1])
	}
	return urls, nil
}

func renderMirrorURL(u, repo, arch string) string {
	u = reRepo.ReplaceAllString(u, repo)
	u = reArch.ReplaceAllString(u, arch)
	if !strings.HasSuffix(u, "/") {
		u += "/"
	}
	return u
}

func arch() string {
	var uts syscall.Utsname
	if err := syscall.Uname(&uts); err != nil {
		log.Fatalf("failed to syscall uname: %v", err)
	}
	var rs []rune
	for _, c := range uts.Machine {
		if c == 0 {
			break
		}
		rs = append(rs, rune(c))
	}
	return string(rs)
}

type fetchedURL struct {
	URL     string
	Elapsed time.Duration
	Failed  bool
}

type mirrorURL struct {
	URL     string
	Fetched []fetchedURL

	avg       float64
	anyFailed bool
}

func (m mirrorURL) Add(f fetchedURL) mirrorURL {
	m.Fetched = append(m.Fetched, f)
	if f.Failed {
		m.anyFailed = true
	} else {
		n := float64(len(m.Fetched))
		m.avg = (m.avg*(n-1) + float64(f.Elapsed)) / n
	}
	return m
}

func (m mirrorURL) AnyFailed() bool {
	for _, f := range m.Fetched {
		if f.Failed {
			return true
		}
	}
	return false
}

func (m mirrorURL) AvgElapsed() time.Duration {
	return time.Duration(m.avg)
}

func fetchURL(mirror, repo, arch string) fetchedURL {
	u := renderMirrorURL(mirror, repo, arch)
	start := time.Now()
	client := http.Client{Timeout: 1 * time.Second}
	resp, err := client.Get(u)
	if err != nil {
		if err, ok := err.(net.Error); ok {
			if !err.Timeout() {
				log.Printf("failed to get url %s: %v", u, err)
			}
		}
		return fetchedURL{Failed: true}
	}
	if resp.StatusCode != 200 {
		log.Printf("bad status code for url %s: %d", u, resp.StatusCode)
		return fetchedURL{Failed: true}
	}
	return fetchedURL{
		URL:     u,
		Elapsed: time.Since(start),
	}
}

func sortMirrors(urls []string) []mirrorURL {
	arch := arch()
	mu := new(sync.Mutex)
	ms := make(map[string]mirrorURL)
	wg := new(sync.WaitGroup)
	sem := make(chan struct{}, 64)
	for _, u := range urls {
		for _, repo := range repos {
			wg.Add(1)
			sem <- struct{}{}
			go func(u, repo string) {
				defer func() {
					<-sem
					wg.Done()
				}()
				f := fetchURL(u, repo, arch)
				mu.Lock()
				m, ok := ms[u]
				if !ok {
					m = mirrorURL{URL: u}
				}
				ms[u] = m.Add(f)
				mu.Unlock()
			}(u, repo)
		}
	}
	wg.Wait()
	var sorted []mirrorURL
	for _, m := range ms {
		if m.AnyFailed() {
			continue
		}
		sorted = append(sorted, m)
	}
	sort.Slice(sorted, func(i, j int) bool {
		return sorted[i].AvgElapsed() < sorted[j].AvgElapsed()
	})
	return sorted
}

func newMirrorFile(ms []mirrorURL) {
	var b strings.Builder
	b.WriteString(fmt.Sprintf(`
##
## Arch Linux repository mirrorlist
## Mirrors sorted by local fetch time
## Generated on %s
##

`, time.Now().Format("2006-01-02")))
	for _, m := range ms {
		b.WriteString(fmt.Sprintf(
			"Server = %s\n",
			m.URL,
		))
	}
	fmt.Println(b.String())
}

func doit() error {
	urls, err := mirrors()
	if err != nil {
		return err
	}
	ms := sortMirrors(urls)
	for _, m := range ms {
		var durs []time.Duration
		for _, f := range m.Fetched {
			durs = append(durs, f.Elapsed)
		}
		// fmt.Println(len(durs), m.AvgElapsed(), m.URL, durs)
	}
	newMirrorFile(ms)
	return nil
}

func main() {
	if err := doit(); err != nil {
		log.Fatalf("failed to update mirrors: %v", err)
	}
}
