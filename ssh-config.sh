#!/bin/bash

configFile=~/.ssh/config
while IFS= read -r serverEntry
do
    serverName=$(echo $serverEntry | awk '{print $1}')
    serverIp=$(echo $serverEntry | awk '{print $2}')

    echo "Host $serverName" >> $configFile
    echo "    HostName $serverIp" >> $configFile
    echo "    User centos" >> $configFile
    echo "    ProxyCommand ssh skyhigh.hig.no nc %h %p" >> $configFile
    echo "" >> $configFile

done <"serverlist"