#!/bin/bash

sudo yum upgrade -y

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce
sudo systemctl enable docker
sudo gpasswd -a $USER docker

sudo yum install -y firewalld
sudo service firewalld start
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --reload

sudo reboot
