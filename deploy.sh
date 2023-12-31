#!/bin/bash

docker build -t lcrowncrpublic.azurecr.io/traceme .
docker push lcrowncrpublic.azurecr.io/traceme
az container create --resource-group rg-prometheus-mock --name traceme --image lcrowncrpublic.azurecr.io/traceme --ports 3333 --dns-name-label traceme
