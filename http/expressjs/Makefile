.PHONY: all build run

all: build

build: index.js package.json package-lock.json
	npm install

run: build
	node ./index.js &

clean:
	rm -rf ./node_modules

