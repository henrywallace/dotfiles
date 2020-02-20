package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"math"
	"os"
	"path/filepath"
	"strconv"
	"strings"
)

var dirBacklight string

func init() {
	dir := "/sys/class/backlight/"
	files, err := ioutil.ReadDir(dir)
	if err != nil {
		log.Fatalf("failed to read %s: %v", dir, err)
	}
	if len(files) == 0 {
		log.Fatalf("%s contains no files: %v", dir, err)
	}
	dirBacklight = filepath.Join(dir, files[0].Name())
}

type status struct {
	Max  int
	Curr int
}

func (s status) Percent() float64 {
	return float64(s.Curr) / float64(s.Max)
}

func readInt(name string) (int, error) {
	path := filepath.Join(dirBacklight, name)
	b, err := ioutil.ReadFile(path)
	if err != nil {
		return 0, err
	}
	s := strings.TrimSpace(string(b))
	i, err := strconv.ParseInt(s, 10, 0)
	if err != nil {
		return 0, err
	}
	return int(i), nil
}

func readStatus() (status, error) {
	max, err := readInt("max_brightness")
	if err != nil {
		return status{}, err
	}

	curr, err := readInt("brightness")
	if err != nil {
		return status{}, err
	}

	return status{max, curr}, nil
}

func setPercent(s status, p float64) error {
	if !(0 < p && p < 1) {
		return fmt.Errorf("percent must be in (0, 1)")
	}
	val := int(math.Round(float64(s.Max) * p))
	valStr := fmt.Sprintf("%d", val)
	path := filepath.Join(dirBacklight, "brightness")
	return ioutil.WriteFile(path, []byte(valStr), 0444)
}

func main() {
	if len(os.Args) != 2 {
		log.Fatal("must provide exactly 1 arg")
	}
	pStr := strings.TrimSpace(os.Args[1])
	p, err := strconv.ParseFloat(pStr, 0)
	if err != nil {
		log.Fatalf("failed to parse '%s' as float: %v", pStr, err)
	}
	s, err := readStatus()
	if err != nil {
		panic(err)
	}
	if err := setPercent(s, p); err != nil {
		panic(err)
	}
}
