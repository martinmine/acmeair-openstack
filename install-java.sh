#!/bin/bash

sudo yum install -y unzip zip 
curl -s "https://get.sdkman.io" | bash
source "/home/centos/.sdkman/bin/sdkman-init.sh"
sdk install java 8u144-zulu

