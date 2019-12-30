package main

import (
	"fmt"
	"log"
	"net"
)

func explore() error {
	ifaces, err := net.Interfaces()
	if err != nil {
		return err
	}
	for _, iface := range ifaces {
		fmt.Println(iface)
		addrs, err := iface.Addrs()
		if err != nil {
			log.Fatal(err)
		}
		for _, addr := range addrs {
			fmt.Printf("\t%v\n", addr)
		}
	}
	return nil
}

func main() {
	if err := explore(); err != nil {
		log.Fatal(err)
	}
}
