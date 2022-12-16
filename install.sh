#!/bin/bash
url="https://raw.githubusercontent.com/RRRRRm/unraid-persistent-home/main/init_home.sh"
mkdir -p /boot/config/home_root
curl -sSL $url -o /boot/config/init_home.sh
chmod +x /boot/config/init_home.sh
ln -s /boot/config/init_home.sh /usr/local/bin/init_home.sh
init_home.sh -p
init_home.sh -fl
echo "bash /boot/config/init_home.sh -fl" >> /boot/config/go
