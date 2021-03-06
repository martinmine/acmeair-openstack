#!/bin/bash
# Updates and installs docker on all the servers

while IFS= read -r serverEntry
do
    serverName=$(echo $serverEntry | awk '{print $1}')
    serverIp=$(echo $serverEntry | awk '{print $2}')
    
    echo "Configuring server $serverName"
    scp -q -oStrictHostKeyChecking=no install-docker.sh $serverName:.
    ssh -n -oStrictHostKeyChecking=no $serverName ./install-docker.sh

done <"serverlist"
