#!/bin/bash

set -e

latency=$1

while IFS= read -r serverEntry
do
    serverName=$(echo $serverEntry | awk '{print $1}')
    serverIp=$(echo $serverEntry | awk '{print $2}')
    serviceName=$(echo $serverEntry | awk '{print $3}')
    
    echo "Setting outgoing latency on service $serviceName@$serverName to $latency ms"
    scp -q _setlat.sh $serverName:.
    ssh -n $serverName ./_setlat.sh $latency

done <"serverlist"

scp -q _setlat.sh acmeair-jmeter1:.
ssh -n acmeair-jmeter1 ./_setlat.sh $latency

