HOST?=127.0.0.1
PORT?=8090

all: build

build: ## Runs gb build on the project
	gb build all

run: build ## Runs the service with local environment unless overridden
	HOST=${HOST} PORT=${PORT} ./bin/example

lint: ## Runs all packages in the service through golint
	GOPATH=$(PWD):$(PWD)/vendor golint example/...

vet: ## Runs all packages in the service through go-vet
	GOPATH=$(PWD):$(PWD)/vendor go vet example/...

test: ## Runs go test with the -v verbose flag
	go test example/... -v

# Deb jazz
build-deb: build ## Builds .deb file(s)
	NAME=example ./f8-deb-helper/build-deb

push-deb: build-deb ## Pushes .deb file(s) to our repository
	NAME=example ./f8-deb-helper/push-deb

version:
	@grep Version deb_example/DEBIAN/control | awk '{ print $2 }'
