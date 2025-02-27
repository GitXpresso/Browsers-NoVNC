#!/bin/bash

# Function to show a progress bar for wget
show_wget_progress() {
  while :; do
    local progress=$(grep -oP '\d+(?=%)' /tmp/wget_progress | tail -1)
    if [ -z "$progress" ]; then
      progress=0
    fi
    local bar="#########################"
    local empty_bar="........................."
    local steps=30
    local step=$((progress * steps / 100))
    printf "\rDownloading: [%-30s] %d%%" "${bar:0:step}${empty_bar:step}" "$progress"
    sleep 0.1
    if [ "$progress" -eq 100 ]; then
      break
    fi
  done
}

# URL of the tar file to download
TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"

# Directory to store the downloaded file
DOWNLOAD_DIR="$HOME"

# Create a temporary file for progress tracking
touch /tmp/wget_progress

# Start the download with wget and capture progress
echo "Downloading the file..."
start_time=$(date +%s)
wget -P "$DOWNLOAD_DIR" --progress=dot "$TAR_URL" 2>&1 | tee /tmp/wget_progress
echo "100" >> /tmp/wget_progress  # Ensure the progress is marked as 100% at the end

# Show the wget progress
show_wget_progress
wait $!

# Calculate the duration of the download
end_time=$(date +%s)
download_duration=$((end_time - start_time))
echo -e "\nDownload completed in ${download_duration}s."

# Export the path of the downloaded file as a variable using the specific command
tarfile=$(wget -P ~/ -nv $TAR_URL 2>&1 | cut -d\" -f2)
echo "Downloaded file: $tarfile"

# Clean up the wget progress file
rm /tmp/wget_progress

# Verify the tar file path
if [ ! -f "$tarfile" ]; then
  echo "Error: Tar file does not exist at $tarfile"
  exit 1
fi

# Function to show a progress bar for tar extraction
show_tar_progress() {
  local total_files=$(tar -tf "$tarfile" | wc -l)
  while :; do
    local extracted_files=$(grep -c '^' /tmp/tar_progress)
    if [ -z "$total_files" ] || [ "$total_files" -eq 0 ]; then
      total_files=1
    fi
    local percentage=$((extracted_files * 100 / total_files))
    if [ "$percentage" -gt 100 ]; then
      percentage=100
    fi
    local bar="#########################"
    local empty_bar="........................."
    local steps=30
    local step=$((percentage * steps / 100))
    printf "\rExtracting: [%-30s] %d%%" "${bar:0:step}${empty_bar:step}" "$percentage"
    sleep 0.1
    if [ "$percentage" -eq 100 ]; then
      break
    fi
  done
}

# Create a temporary file for progress tracking
touch /tmp/tar_progress

# Prepare for tar extraction
echo "Extracting the tar file..."
start_time=$(date +%s)
total_files=$(tar -tf "$tarfile" | wc -l)

# Start the extraction with tar, capture progress, and export the tar directory
TAR_DIR=$(tar -xvf "$tarfile" -C "$DOWNLOAD_DIR" | tee /tmp/tar_progress | cut -d / -f1 | uniq)

# Show the tar extraction progress
show_tar_progress
wait $!

# Calculate the duration of the extraction
end_time=$(date +%s)
extraction_duration=$((end_time - start_time))
echo -e "\nExtraction completed in ${extraction_duration}s."

# Export the directory created from the extracted tar file
echo "$TAR_DIR"
# Clean up the temporary tar progress files
rm /tmp/tar_progress 
