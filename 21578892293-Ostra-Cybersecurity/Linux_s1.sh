#!/bin/bash

sentinelToken="https://raw.githubusercontent.com/chetan-ostra/ocs-epdr/refs/heads/main/21578892293-Ostra-Cybersecurity/ostra-token.txt"
downloadLink1="https://raw.githubusercontent.com/chetan-ostra/ocs-epdr/refs/heads/main/pkgs/SentinelAgent_linux_x86_64_v23_3_2_12.deb"
#downloadLink="https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/refs/heads/main/SentinelAgent_linux_x86_64_v23_3_2_12.deb"
pkgName="SentinelAgent_linux_x86_64_v23_3_2_12.deb"
#You can put the installer on dropbox or where you prefer.
if [ -d "/opt/sentinelone/" ];
then
        echo "Already Installed"
  exit 0
else
cd /tmp
#Download Agent
curl -O $downloadLink1 $sentinelToken
#Install Agent
chmod +x $downloadLink1 $sentinelToken
dpkg -i $pkgName
#Set Token
/opt/sentinelone/bin/sentinelctl management token set $sentinelToken
#Start Agent
/opt/sentinelone/bin/sentinelctl control start
fi
