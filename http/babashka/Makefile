.PHONY: all build run

all: build

build: http.clj
	bb -f ./http.clj --only-download-deps

run:
	bb -f ./http.clj &
