package app

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/pmackay-w/wdc/frontend"
)

type Config struct {
	port string
}

func NewConfig() *Config {
	var cfg Config
	cfg.port = "80"

	if p := os.Getenv("PORT"); p != "" {
		cfg.port = p
	}

	return &cfg
}

func Run(cfg *Config) error {
	staticFiles, err := frontend.GetFiles()

	if err != nil {
		return err
	}

	fs := http.FileServer(http.FS(staticFiles))

	// Serve static files
	http.Handle("/", fs)

	log.Printf("Listening on :%s\n", cfg.port)
	err = http.ListenAndServe(fmt.Sprintf(":%s", cfg.port), nil)
	if err != nil {
		log.Fatal(err)
	}
	return nil
}
