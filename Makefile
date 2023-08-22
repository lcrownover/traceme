.PHONY: all install clean

all:
	@go build -o bin/traceme cmd/traceme/main.go

install:
	@cp bin/traceme /usr/local/bin/traceme

clean:
	@rm -f bin/traceme /usr/local/bin/traceme

deploy: 
	@docker build --platform=linux/amd64 -t lcrowncrpublic.azurecr.io/traceme .
	@docker push lcrowncrpublic.azurecr.io/traceme
	@az container create --resource-group rg-prometheus-mock --name traceme --image lcrowncrpublic.azurecr.io/traceme --ports 3333 --dns-name-label traceme
	@az container restart --resource-group rg-prometheus-mock --name traceme
