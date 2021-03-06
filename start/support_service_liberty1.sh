#!/bin/bash
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)


if [[ "$1" != "fast" ]]; then 
    docker pull martinmine/acmeairjava_support_service_liberty1
fi

docker run -d -p 80:80 --name support_service_liberty1 martinmine/acmeairjava_support_service_liberty1
