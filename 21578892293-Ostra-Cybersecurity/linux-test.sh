#!/bin/bash

REPO_URL="https://github.com/chetan-ostra/ocs-epdr.git"
BRANCH="main"
#CUST_NAME="ocs-epdr/21578892293-Ostra-Cybersecurity"
LOCAL_DIR="/tmp/s1"
FILE_PATH="/tmp/s1/pkgs/SentinelAgent_linux_x86_64_v23_3_2_12.deb"
TOKEN_FILE="/tmp/s1/21578892293-Ostra-Cybersecurity/ostra-token.txt"
echo "Cloning the repository..."
git clone --branch "$BRANCH" "$REPO_URL" "$LOCAL_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

cd "$LOCAL_DIR" || exit

if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' does not exist in the repository."
    exit 1
fi

RAW_URL="https://raw.githubusercontent.com/chetan-ostra/ocs-epdr/"

echo "Downloading file from GitHub..."
curl -L -o "$(basename "$FILE_PATH")" "$RAW_URL"
if [ $? -ne 0 ]; then
    echo "Error: Failed to download the file from GitHub."
    exit 1
fi

echo "Making the file executable..."
chmod +x "$(basename "$FILE_PATH")"
if [ $? -ne 0 ]; then
    echo "Error: Failed to make the file executable."
    exit 1
fi

echo "Executing the file..."
./"$(basename "$FILE_PATH")"
if [ $? -ne 0 ]; then
    echo "Error: Failed to execute the file."
    exit 1
fi

cd /tmp/s1/

chmod +x $FILE_PATH $TOKEN_FILE
dpkg -i "/tmp/s1/pkgs/SentinelAgent_linux_x86_64_v23_3_2_12.deb"

/opt/sentinelone/bin/sentinelctl management token set $TOKEN_FILE
/opt/sentinelone/bin/sentinelctl control start

echo "File executed successfully!"