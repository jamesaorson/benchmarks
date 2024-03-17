.PHONY: all build clean run

all: build

build:
	dotnet restore
	dotnet build --configuration Release

run: build
	dotnet run --configuration Release &

clean:
	dotnet clean
