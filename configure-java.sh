#!/bin/bash

set -e

while IFS= read -r serverEntry
do
    serverName=$(echo $serverEntry | awk '{print $1}')
    serverIp=$(echo $serverEntry | awk '{print $2}')
    serviceName=$(echo $serverEntry | awk '{print $3}')
    
    echo "Installing java on $serviceName@$serverName"
    scp -q install-java.sh $serverName:.
    ssh -n $serverName ./install-java.sh

done <"serverlist"

