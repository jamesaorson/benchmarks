.PHONY: all build run

all: build

build: zig-out/bin/zig-std

zig-out/bin/zig-std:
	zig build -Doptimize=ReleaseFast

run: zig-out/bin/zig-std
	./zig-out/bin/zig-std &

clean:
	rm -rf zig-out
