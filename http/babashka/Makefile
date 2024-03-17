.PHONY: all build run

all: build

build: build/babashka

build/babashka: http.clj
	mkdir -p ./build
	bb uberscript ./build/babashka ./http.clj

run: build/babashka
	bb ./build/babashka &

clean:
	rm -rf ./build
