#!/bin/bash
set -e

source MACS490_H17_martisny-openrc.sh
imageID=$(openstack image list --property name="CentOS 7 x86_64" -c ID -f value)
echo "Using image $imageID"
networkID=$(openstack network list -f value | grep "acmeair-network" | awk -F ' ' '{print $1}')
echo "Using network $networkID"
keyName='skyhigh'

while IFS= read -r serverHostname
do
    serverId=''

    echo "Attempting to spawn instance $serverHostname with image ID $imageID and network ID $networkID"
    openstack server create --image $imageID --flavor m1.medium --security-group default --key-name $keyName --nic net-id=$networkID $serverHostname

    while [[ $serverId == '' ]]
    do
        serverId=$(openstack server list -f value | grep $serverHostname | grep ACTIVE | awk -F ' ' '{print $1}')
        if [[ $serverId == '' ]]; then
            echo "Waiting for status to become active"
            sleep 1
        fi
    done

    echo "Server spawned"

    echo "Creating floating IP"
    floatingIp=$(openstack floating ip create ext-net | grep floating_ip_address | awk -F ' ' '{print $4}')
    echo "Setting floating IP"
    openstack server add floating ip $serverHostname $floatingIp

    echo "$serverHostname	$floatingIp" >> serverlist
    echo "Server $serverHostname ($floatingIp) configured"
done <"hostnames"

echo "Server list:"
cat serverlist