#!/bin/bash

echo "" >> ~/.bashrc
echo "export LC_ALL=C" ~/.bashrc

apt-get update
apt-get upgrade -y
apt-get install -y python2.7 python3 python-pip
apt-get install -y htop nano dnsutils git 
apt-get install -y build-essential
apt-get dist-upgrade -y
wget -qO- https://get.docker.com/ | sh
#usermod -aG docker docker-user
init 6
