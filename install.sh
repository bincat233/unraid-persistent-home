#!/bin/bash
mkdir -p /boot/config/home_root
echo "Downloading the script..."
curl -sSL https://raw.githubusercontent.com/RRRRRm/unraid-persistent-home/main/init_home.sh > /boot/config/init_home.sh
cp -f /boot/config/init_home.sh /usr/local/bin/init_home.sh
chmod +x /usr/local/bin/init_home.sh
echo "Copying all existing files from /root to /boot/config/home_root ..."
bash /boot/config/init_home.sh -p
bash /boot/config/init_home.sh -fl
grep -qF "init_home.sh" /boot/config/go || echo "bash /boot/config/init_home.sh -fl" >> /boot/config/go
echo "Done!"
