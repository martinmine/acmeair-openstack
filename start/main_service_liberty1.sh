#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_main_service_liberty1
    docker pull martinmine/nginx-adapter
fi 

docker run -d --network="local-net" -p 8080:80 --name main_service_liberty1 martinmine/acmeairjava_main_service_liberty1
docker run -d --network="local-net" -p 80:80 --name proxy martinmine/nginx-adapter 80 main_service_liberty1
