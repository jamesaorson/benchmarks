.PHONY: all build run

all: build

build: build/golang

build/golang: main.go
	go build -o ./build/golang main.go

run: build/golang
	./build/golang &
