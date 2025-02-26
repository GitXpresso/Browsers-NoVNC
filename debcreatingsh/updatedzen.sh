
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
DOWNLOAD_DIR=~

# Create a temporary file for progress tracking
touch /tmp/wget_progress

# Start the download with wget and capture progress
echo "Downloading the file..."
start_time=$(date +%s)
{
  wget -P ~/ --progress=dot "$TAR_URL" 2>&1 | tee /tmp/wget_progress | grep -oP '(?<=Saving to: ).*' > /tmp/tarfile
  echo "100" >> /tmp/wget_progress  # Ensure the progress is marked as 100% at the end
} &
show_wget_progress
wait $!

# Calculate the duration of the download
end_time=$(date +%s)
download_duration=$((end_time - start_time))
echo -e "\nDownload completed in ${download_duration}s."

# Export the path of the downloaded file as a variable
tarfile=$(cat /tmp/tarfile)
echo "Downloaded file: $tarfile"

# Clean up the temporary progress file
rm /tmp/wget_progress /tmp/tarfile
TAR_DIR=$(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq)
