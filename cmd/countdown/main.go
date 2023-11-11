package main

import (
	"log"

	app "github.com/pmackay-w/wdc/cmd/countdown/internal"
)

func main() {
	cfg := app.NewConfig()
	err := app.Run(cfg)
	if err != nil {
		log.Fatal(err)
	}
}
