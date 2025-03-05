#!/bin/bash

SITE_TOKEN=$(curl -s https://github.com/ocs-eb1/ocs-epdr/site_token.txt)

if [ -z "$ITE_TOKEN" ]; then
    echo "Error: Could not retrieve Site Token from GitHub."
    exit 1
fi 

if [[ $(uname -s) == "Darwin" ]]; then
    INSTALLER_URL="https://github.com/ocs-eb1/ocs-epdr/Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
    INSTALL_CMD="installer -pkg $INSTALLER_URL -target /"
elif [[ $(uname -s) == "Linux" ]]; then
    INSTALLER_URL="https://github.com/ocs-eb1/ocs-epdr/SentinelAgent_linux_x86_64_v23_3_2_12.deb"
    INSTALL_CMD="sudo dpkg -i $INSTALLER_URL"
else
    echo "Unsupported operating system."
    exit 1
fi

echo "Downloading SentinelOne Agent..."
wget -O s1-agent.pkg "$INSTALLER_URL"

echo "Installing SentinelOne Agent..."
sudo $INSTALL_CMD -t "$SITE_TOKEN" 


if [ $? -eq 0 ]; then
    echo "SentinelOne Agent installed successfully."
else
    echo "Installation failed."
fi 

rm s1-agent.pkg 