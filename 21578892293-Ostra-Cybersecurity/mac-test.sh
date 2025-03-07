#!/bin/bash

REPO_URL="https://github.com/chetan-ostra/ocs-epdr.git"
BRANCH="main" 
LOCAL_DIR="/tmp/s1"
FILE_PATH="/tmp/s1/pkgs/Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
TOKEN_FILE="/tmp/s1/21578892293-Ostra-Cybersecurity/ostra-token.txt"
#TOKEN_FILE="/path/to/token/file"  # Specify the correct path to your token file

if [ -d "$LOCAL_DIR" ]; then
    echo "Removing existing directory: $LOCAL_DIR"
    rm -rf "$LOCAL_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to remove the existing directory."
        exit 1
    fi
fi

echo "Cloning the repository into $LOCAL_DIR..."
git clone --branch "$BRANCH" "$REPO_URL" "$LOCAL_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

cd "$LOCAL_DIR" || { echo "Error: Failed to navigate to the local directory."; exit 1; }

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' does not exist in the repository."
    exit 1
fi

echo "Installing the package..."
sudo installer -pkg "$FILE_PATH" -target /
if [ $? -ne 0 ]; then
    echo "Error: Failed to install the package."
    exit 1
fi

echo "Setting the management token and starting SentinelOne..."
sudo /opt/sentinelone/bin/sentinelctl management token set "$TOKEN"
if [ $? -ne 0 ]; then
    echo "Error: Failed to set the management token."
    exit 1
fi

sudo /opt/sentinelone/bin/sentinelctl control start
if [ $? -ne 0 ]; then
    echo "Error: Failed to start SentinelOne."
    exit 1
fi

echo "File executed successfully!"