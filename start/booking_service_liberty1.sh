#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_booking_service_liberty1
fi

docker network create --driver bridge local-net
docker run -d --network="local-net" --name booking_db1 mongo
docker run -d --network="local-net" -p 80:80 --name booking_service_liberty1 martinmine/acmeairjava_booking_service_liberty1
