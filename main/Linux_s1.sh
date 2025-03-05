#!/bin/bash

sentinelToken="eyJ1cmwiOiAiaHR0cHM6Ly91c2VhMS0wMDItbXNzcC5zZW50aW5lbG9uZS5uZXQiLCAic2l0ZV9rZXkiOiAiNGJjZGQ1ZDJmMjk4NDhjNCJ9"
downloadLink="https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/refs/heads/main/SentinelAgent_linux_x86_64_v23_3_2_12.deb"
pkgName="SentinelAgent_linux_x86_64_v23_3_2_12.deb"

#You can put the installer on dropbox or where you prefer.

if [ -d "/opt/sentinelone/" ];
then
        echo "Already Installed"
  exit 0
else

cd /tmp

#Download Agent
wget $pkgName $downloadLink

#Install Agent
#chmod +x $pkgName
dpkg -i $pkgName

#Set Token
/opt/sentinelone/bin/sentinelctl management token set $sentinelToken

#Start Agent
/opt/sentinelone/bin/sentinelctl control start

fi
