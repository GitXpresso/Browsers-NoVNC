#!/bin/bash

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

# Path to the tar file to extract
tarfile="$HOME/zen.linux-x86_64.tar.xz"

# Directory to extract the tar file
extract_dir="$HOME"

# Create a temporary file for progress tracking
touch /tmp/tar_progress

# Check if the tar file exists and is not empty
if [ ! -s "$tarfile" ]; then
  echo "Error: Tar file is empty or does not exist."
  exit 1
fi

# Prepare for tar extraction
echo "Extracting the tar file..."
start_time=$(date +%s)
total_files=$(tar -tf "$tarfile" | wc -l)

# Start the extraction with tar, capture progress, and export the tar directory
tar -xvf "$tarfile" -C "$extract_dir" | tee /tmp/tar_progress | cut -d / -f1 | uniq > /tmp/tar_dir &
show_tar_progress
wait

# Calculate the duration of the extraction
end_time=$(date +%s)
extraction_duration=$((end_time - start_time))
echo -e "\nExtraction completed in ${extraction_duration}s."

# Export the directory created from the extracted tar file
TAR_DIR=$(cat /tmp/tar_dir)
export EXTRACTED_DIR="$extract_dir/$TAR_DIR"
echo "Extracted directory: $EXTRACTED_DIR"

# Clean up the temporary progress file
rm /tmp/tar_progress /tmp/tar_dir
