#!/bin/bash

# Function to show a loading bar for wget
show_wget_loading_bar() {
  while :; do
    local progress=$(grep -oP '\d+(?=%)' /tmp/wget_progress | tail -1)
    local bar="#########################"
    local empty_bar="........................."
    local steps=30
    local step=$((progress * steps / 100))
    printf "\r[%-30s] %d%%" "${bar:0:step}${empty_bar:step}" "$progress"
    sleep 0.1
  done
}

# URL of the file to download
FILE_URL="https://mirrors.iu13.net/blender/release/Blender4.3/blender-4.3.2-linux-x64.tar.xz"

# Directory to store the downloaded file
DOWNLOAD_DIR=~/

# Start the download with wget and capture progress
echo "Downloading the file..."
start_time=$(date +%s)
wget -P ~/ --progress=bar:force "$FILE_URL" 2>&1 | tee /tmp/wget_progress && clear & 
wget_pid=$!
# Start the loading bar
show_wget_loading_bar &
loading_pid=$!
wait $wget_pid
kill $loading_pid

# Calculate the duration of the download
end_time=$(date +%s)
download_duration=$((end_time - start_time))

# Export the path of the downloaded file
tarfile=$(grep -oP '(?<=‘).*?(?=’ is saved)' /tmp/wget_progress | cut -d\" -f2)

# Output the path of the downloaded file and the duration of the download
echo -e "\nDownload completed in ${download_duration}s."
echo "Downloaded file: $downloaded_file"

# Clean up the temporary progress file
rm /tmp/wget_progress

# Export the path of the downloaded file as a variable
export DOWNLOADED_FILE_PATH="$tarfile"
echo "Exported path: $DOWNLOADED_FILE_PATH"

# URL of the tar file to download
