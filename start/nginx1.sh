#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)

if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_nginx1
fi 

docker network create --driver bridge local-net
docker run -d --name h2cproxy --network=local-net svagi/nghttp2 nghttpx --frontend='*,80;no-tls' --backend='172.16.1.54,80;/;proto=h2;no-tls' --backend='172.16.1.139,80;/acmeair-as/;proto=h2;no-tls' --backend='172.16.1.110,80;/acmeair-bs/;proto=h2;no-tls' --backend='172.16.1.137,80;/acmeair-cs/;proto=h2;no-tls' --backend='172.16.1.3,80;/acmeair-fs/;proto=h2;no-tls' --backend='172.16.1.145,80;/acmeair-ss/;proto=h2;no-tls' 
docker run -d --network="local-net" -p 80:80 --name nginx1 martinmine/acmeairjava_nginx1
