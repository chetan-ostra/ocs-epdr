#!/bin/bash

GITHUB_URL="https://github.com/chetan-ostra/ocs-epdr.git"
TEMP_DIR="/tmp/s1"
REGISTRATION_TOKEN="/tmp/s1/21578892293-Ostra-Cybersecurity/ostra-token.txt"
FILE="/tmp/s1/pkgs/Sentinel-Release-24-1-3-7587_macos_v24_1_3_7587.pkg.pkg"

if [[ -z "$GITHUB_URL" ]]; then
    echo "Usage: ./install_s1_agent.sh <GitHub_Repo_URL> <Registration_Token>"
    exit 1
fi

echo "Downloading SentinelOne agent from GitHub..."
git clone "$GITHUB_URL" "$TEMP_DIR"

if [[ $? -ne 0 ]]; then
    echo "Failed to download the SentinelOne agent package. Exiting."
    exit 1
fi

echo "Applying token..."
TOKEN=$(cat "$REGISTRATION_TOKEN")
if [ $? -ne 0 ]; then
    echo "Error: Failed to read the token from the file."
    exit 1
fi
echo "Applying registration token..."
echo "$TOKEN" | sudo tee "/tmp/com.sentinelone.registration-token" > /dev/null
echo "$TOKEN" | sudo tee "/Library/Managed Preferences/com.sentinelone.registration-token" > /dev/null
#echo "$TOKEN" | sudo tee /Library/Managed\ Preferences/com.sentinelone.registration-token > /dev/null

if [[ $? -ne 0 ]]; then
    echo "Failed to apply the registration token. Exiting."
    exit 1
fi

echo "Installing SentinelOne agent..."
sudo installer -pkg "$FILE" -target /

if [[ $? -ne 0 ]]; then
    echo "Failed to install SentinelOne agent. Exiting."
    exit 1
fi

rm -rf "$TEMP_DIR"

echo "SentinelOne agent installed successfully."

exit 0
