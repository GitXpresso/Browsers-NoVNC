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

# Function to show a progress bar for tar extraction
show_tar_progress() {
  local total_files=$(tar -tf "$tarfile" | wc -l)
  while :; do
    local extracted_files=$(grep -c '^' /tmp/tar_progress)
    if [ -z "$total_files" ] || [ "$total_files" -eq 0 ]; then
      total_files=1
    fi
    local percentage=$((extracted_files * 100 / total_files))
    if [ -z "$percentage" ]; then
      percentage=0
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

# URL of the tar file to download
TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"

# Directory to store the downloaded file

# Create temporary files for progress tracking
touch /tmp/wget_progress /tmp/tar_progress

# Start the download with wget and capture progress
echo "Downloading the file..."
start_time=$(date +%s)
{
  wget -P ~/ --progress=dot "$TAR_URL" 2>&1 | tee /tmp/wget_progress | grep -oP '(?<=Saving to: ).*' > /tmp/tarfile
  echo "100" >> /tmp/wget_progress  # Ensure the progress is marked as 100% at the end
} &
show_wget_progress &
wait $!

# Calculate the duration of the download
end_time=$(date +%s)
download_duration=$((end_time - start_time))
echo -e "\nDownload completed in ${download_duration}s."

# Export the path of the downloaded file as a variable
tarfile=$(cat /tmp/tarfile)
export DOWNLOADED_FILE_PATH="$tarfile"
echo "Downloaded file: $DOWNLOADED_FILE_PATH"

if [[ "$answer" == "yes" ]]; then
  echo "Do you want to rename all files to a single name or rename each file manually? (all/manual)"
  read rename_choice
  if [[ "$rename_choice" == "all" ]]; then
    echo "Renaming all files..."
    for dir in "${dest_dirs[@]}"; do
      rename_all_files "$dir"
    done
    echo "All files have been renamed."
  elif [[ "$rename_choice" == "manual" ]]; then
    echo "Renaming files manually..."
    for dir in "${dest_dirs[@]}"; do
      for file in "$dir"/*; do
        if [[ -f "$file" ]]; then
          rename_each_file "$file"
        fi
      done
    done
    echo "Files have been renamed manually."
  else
    echo "Invalid choice. No files have been renamed."
  fi
else
  echo "Files have not been renamed