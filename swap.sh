#!/bin/bash
# quocbao747
# Ref: https://meta.discourse.org/t/create-a-swapfile-for-your-linux-server/13880

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

install -o root -g root -m 0600 /dev/null /swapfile
dd if=/dev/zero of=/swapfile bs=4k count=1048k
mkswap /swapfile
swapon /swapfile
echo "/swapfile       swap    swap    auto      0       0" | sudo tee -a /etc/fstab
sudo sysctl -w vm.swappiness=20
echo vm.swappiness = 20 | sudo tee -a /etc/sysctl.conf

exit 0
