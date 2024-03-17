.PHONY: all build run

all: build

build: http.clj
	bb -f ./http.clj --no-serve

run:
	bb -f ./http.clj &
