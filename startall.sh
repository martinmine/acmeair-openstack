#!/bin/bash

set -e

while IFS= read -r serverEntry
do
    serverName=$(echo $serverEntry | awk '{print $1}')
    serverIp=$(echo $serverEntry | awk '{print $2}')
    serviceName=$(echo $serverEntry | awk '{print $3}')
    
    echo "Initiating service $serviceName@$serverName"
    scp start/$serviceName.sh $serverName:.
    ssh -n $serverName ./$serviceName.sh fast

done <"serverlist"
