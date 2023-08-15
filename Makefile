.PHONY: all install clean

all:
	@go build -o bin/traceme cmd/traceme/main.go

install:
	@cp bin/traceme /usr/local/bin/traceme

clean:
	@rm -f bin/traceme /usr/local/bin/traceme

