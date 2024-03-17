.PHONY: all build run

all: build

build: http.clj
	bb prepare ./http.clj

run: build
	bb ./http.clj
