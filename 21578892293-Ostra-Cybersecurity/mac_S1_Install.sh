#!/bin/sh
siteToken="https://github.com/ocs-eb1/ocs-epdr/blob/main/21578892293-Ostra-Cybersecurity/ostra-token.txt"
installerurl="https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/refs/heads/main/Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
installer="Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
dir="/tmp/"
tokenfile="com.sentinelone.registration-token"

if [-d /Application/SentinelOne/ ];
then
        echo "SentinelOne is already Installed"
else
        wget $dir$installer $dirinstallerurl $siteToken
        echo $siteToken > $dir$tokenfile
        /usr/sbin/installer -pkg $dir$installer -target /
        rm -f $dir$tokenfile
fi
