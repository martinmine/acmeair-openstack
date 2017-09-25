#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_auth_service_liberty1
    docker pull martinmine/coap-gateway
fi

docker network create --driver bridge local-net
docker run -d --network="local-net" --name session_db1 mongo
docker run -d --network="local-net" -p 80:80 --name auth-service-liberty1 martinmine/acmeairjava_auth_service_liberty1
docker run -d --network="local-net" -p 5683:5683/udp --name proxy martinmine/coap-gateway --mode=coap
