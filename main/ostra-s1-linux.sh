#!/bin/bash

REPO_URL="https://github.com/chetan-ostra/ocs-epdr.git"
BRANCH="main"  
LOCAL_DIR="/tmp/s1" 
FILE_PATH="/tmp/s1/pkgs/SentinelAgent_linux_x86_64_v23_3_2_12.deb"
TOKEN_FILE="/tmp/s1/21578892293-Ostra-Cybersecurity/ostra-token.txt" #update token with the script and host them internally.


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

echo "Making the file executable..."
chmod +x "$FILE_PATH"
if [ $? -ne 0 ]; then
    echo "Error: Failed to make the file executable."
    exit 1
fi

echo "Executing the file..."
dpkg -i "$FILE_PATH"
if [ $? -ne 0 ]; then
    echo "Error: Failed to execute the file."
    exit 1
fi

echo "applying token"
TOKEN=$(cat "$TOKEN_FILE")
if [ $? -ne 0 ]; then
    echo "error token file"
    exit 1
fi

/opt/sentinelone/bin/sentinelctl management token set $TOKEN
/opt/sentinelone/bin/sentinelctl control start
rm -rf $LOCAL_DIR
echo "File executed successfully!"
