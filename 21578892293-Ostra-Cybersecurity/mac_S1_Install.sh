#!/bin/sh
REPO_URL="https://github.com/chetan-ostra/ocs-epdr.git"
BRANCH="main" # not required as per new design; make changes to branch 
LOCAL_DIR="/tmp/s1" # remove folder after installation
FILE_PATH="/tmp/s1/pkgs/Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
#installerurl="https://raw.githubusercontent.com/ocs-eb1/ocs-epdr/refs/heads/main/Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
#installer="Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
dir="/tmp/s1"
tokenfile="com.sentinelone.registration-token"

if [ -d /Application/SentinelOne/ ];
then
        echo "SentinelOne is already Installed"
else
        wget $FILE_PATH $siteToken
        echo $siteToken > $dir$tokenfile
        /usr/sbin/installer -pkg $dir$installer -target /
        rm -f $dir$tokenfile
fi


