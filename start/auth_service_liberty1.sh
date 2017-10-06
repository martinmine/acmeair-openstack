#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_auth_service_liberty1
    docker pull martinmine/nginx-adapter
fi

docker network create --driver bridge local-net
docker run -d --network="local-net" --name session_db1 mongo
docker run -d --network="local-net" -p 8080:80 --name auth_service_liberty1 martinmine/acmeairjava_auth_service_liberty1
docker run -d --network="local-net" -p 80:80 --name proxy svagi/nghttp2 nghttpx --frontend='*,80;no-tls' --backend='auth_service_liberty1,80;;proto=http/1.1;no-tls'