.PHONY: all build run

all: build

build: compiled

compiled: http.rkt
	raco exe ./http.rkt

run: http
	./http
