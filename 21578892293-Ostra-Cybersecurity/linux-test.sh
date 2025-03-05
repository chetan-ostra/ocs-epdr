#!/bin/bash

# Set the GitHub repository details
REPO_URL="https://github.com/chetan-ostra/ocs-epdr.git"
BRANCH="main" # Use your branch name, e.g., 'main' or 'master'
FILE_PATH="ocs-epdr/21578892293-Ostra-Cybersecurity/linux-test.sh" # Path to the file you want to download and execute (relative to repo root)
LOCAL_DIR="/tmp/" # The local directory where the repo will be cloned (optional)

# Step 1: Clone the GitHub repository
echo "Cloning the repository..."
git clone --branch "$BRANCH" "$REPO_URL" "$LOCAL_DIR"
if [ $? -ne 0 ]; then
    echo "Error: Failed to clone the repository."
    exit 1
fi

cd "$LOCAL_DIR" || exit

# Step 2: Check if the file exists in the repository
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' does not exist in the repository."
    exit 1
fi

# Step 3: Download the file using curl (alternative to cloning the whole repo)
# If you just want to download a single file from GitHub raw content, use the following curl command
# This will download the file from GitHub raw URL
RAW_URL="https://raw.githubusercontent.com/chetan-ostra/ocs-epdr/$BRANCH/$FILE_PATH"

echo "Downloading file from GitHub..."
curl -L -o "$(basename "$FILE_PATH")" "$RAW_URL"
if [ $? -ne 0 ]; then
    echo "Error: Failed to download the file from GitHub."
    exit 1
fi

# Step 4: Make the file executable (if it's a script)
echo "Making the file executable..."
chmod +x "$(basename "$FILE_PATH")"
if [ $? -ne 0 ]; then
    echo "Error: Failed to make the file executable."
    exit 1
fi

# Step 5: Execute the file (only if it's an executable script)
echo "Executing the file..."
./"$(basename "$FILE_PATH")"
if [ $? -ne 0 ]; then
    echo "Error: Failed to execute the file."
    exit 1
fi

echo "File executed successfully!"
