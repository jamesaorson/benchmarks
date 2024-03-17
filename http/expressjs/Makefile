.PHONY: all build run

all: build

build: index.js package.json package-lock.json
	npm install

run: node_modules
	node ./index.js &
