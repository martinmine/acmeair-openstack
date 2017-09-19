#!/bin/bash
set -e 

if [ "$(/usr/sbin/tc -s qdisc | grep netem)" ]
then
    echo "Config is set, removing old rule"
    sudo /usr/sbin/tc qdisc del dev eth0 root netem
fi

if [ "$1" == "0" ]
then
    echo "No need to add new rule for ${1}ms, exiting"
    exit
fi

sudo /usr/sbin/tc qdisc add dev eth0 root netem delay ${1}ms

