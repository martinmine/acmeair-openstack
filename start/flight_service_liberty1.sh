#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_flight_service_liberty1
fi

docker network create --driver bridge local-net
docker run -d --network="local-net" --name flight_db1 mongo
docker run -d --network="local-net" -p 8080:80 --name flight_service_liberty1 martinmine/acmeairjava_flight_service_liberty1
docker run -d --network="local-net" -p 80:80 --name proxy martinmine/nginx-adapter 80 flight_service_liberty1:8080

