.PHONY: all build clean run

EXECUTABLE := bin/Debug/net7.0/fsharp

all: build

build:
	dotnet restore
	dotnet build --configuration Release

run: build
	dotnet run --configuration Release &

clean:
	dotnet clean
