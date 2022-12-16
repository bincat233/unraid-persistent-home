#!/bin/bash
mkdir -p /boot/config/home_root
curl -sSL https://raw.githubusercontent.com/RRRRRm/unraid-persistent-home/main/init_home.sh > /boot/config/init_home.sh
bash /boot/config/init_home.sh -p
bash /boot/config/init_home.sh -fl
grep -qF "init_home.sh" /boot/config/go || echo "bash /boot/config/init_home.sh -fl" >> /boot/config/go
