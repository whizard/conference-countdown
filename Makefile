# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

.EXPORT_ALL_VARIABLES:

PHONY: help clean gotest golint backend update

GITREV :=$(shell git rev-list HEAD --count)
GITHASH :=$(shell git rev-parse HEAD)
GITBRANCH :=$(shell git symbolic-ref --short HEAD)

GOOS :=$(shell uname -s | tr A-Z a-z)


GO_LDFLAGS :=-ldflags "-s -w -X ${INFOPATH}.appInfo=${APPINFO} -X ${DAEMON_INFOPATH}.appInfo=${APPINFO} -X ${VPATH}.commitHash=${GITHASH} -X ${VPATH}.branch=${GITBRANCH}"
GO_FLAGS :=-trimpath

CGO_ENABLED := 0
GO111MODULE:=auto

all: clean gotest golint web backend

build: backend ## Build project
	@echo "Built project"

backend: gotest ## Build the backend
	@echo "Building backend"
	@mkdir -p dist
	@go build -o dist $(GO_LDFLAGS) $(GO_FLAGS) ./cmd/countdown ./frontend

gotest: ## Go test
	@echo "Go test"
	@go test ./...

golint: ## Go linting
	@echo "Go linting"
	@golangci-lint run

update:   ## Update go.mod, go.sum and node modules
	@echo 'Update modules ...'
	@go mod tidy

clean:
	@echo "Cleaning"
	@go clean -modcache
	@rm -rf dist/*.*	
