#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_nginx1
fi 

docker network create --driver bridge local-net
docker run -d --network="local-net" -p 8080:80 --name nginx1 martinmine/acmeairjava_nginx1
docker run -d --network="local-net" -p 80:80 --name proxy martinmine/nginx-adapter 80 nginx1