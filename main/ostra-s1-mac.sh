#!/bin/bash
REPO_URL="https://github.com/chetan-ostra/ocs-epdr.git"
BRANCH="main" 
LOCAL_DIR="/tmp/s1"
FILE_PATH="/tmp/s1/pkgs/Sentinel-Release-23-3-2-7123_macos_v23_3_2_7123.pkg"
TOKEN_FILE="/tmp/s1/pkgs/com.sentinelone.registration-token"

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

echo "Applying registration token"
echo "$TOKEN" | sudo tee "/tmp/com.sentinelone.registration-token" > /dev/null

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

rm -rf $LOCAL_DIR
echo "File executed successfully!"