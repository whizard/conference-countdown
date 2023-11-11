package frontend

import (
	"embed"
	"io/fs"
)

//go:embed all:build

var files embed.FS

func GetFiles() (fs.FS, error) {

	htmlContent, err := fs.Sub(files, "build")
	return htmlContent, err
}
