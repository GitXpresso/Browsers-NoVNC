#!/bin/bash

# Set the specified directory for building the package
specified_directory="$HOME/$1"  # Accept the directory name as an argument

# Check if the directory exists
if [[ ! -d "$specified_directory" ]]; then
  echo "Error: Directory '$specified_directory' does not exist."
  exit 1
fi

# Output directory for the .deb file
deb_output_dir="$specified_directory"

# Function to display the loading bar
show_loading_bar() {
  total_steps=$1
  current_step=0
  while [[ $current_step -le $total_steps ]]; do
    percentage=$(( (current_step * 100) / total_steps ))
    bar="["  # Initialize the bar
    for ((i=0; i<percentage/2; i++)); do
      bar+="#"
    done
    for ((i=percentage/2; i<50; i++)); do
      bar+="-"
    done
    bar+="] $percentage%"
    echo -ne "\r$bar"  # Update the loading bar on the same line
    sleep 0.1  # Simulate progress (you can adjust the speed)
    ((current_step++))
  done
  echo  # New line after the loading bar
}

# Start building the Debian package
echo "Starting dpkg-deb build for '$specified_directory'..."

# Create the .deb package
(
  # Run dpkg-deb build and track the progress
  dpkg-deb build "$specified_directory" &  # Start building in background

  # Track the .deb file size as it grows
  deb_file="$deb_output_dir/$(basename "$specified_directory")".deb

  # Wait for the deb file to start appearing
  while [[ ! -f "$deb_file" ]]; do
    sleep 0.1
  done

  # Track the size of the deb file over time
  prev_size=0
  while [[ -f "$deb_file" ]]; do
    current_size=$(stat --format="%s" "$deb_file")
    if [[ $current_size -gt $prev_size ]]; then
      # Update the loading bar based on the size increase
      show_loading_bar $(( (current_size - prev_size) / 1000 ))  # 1 KB per step (you can adjust this)
      prev_size=$current_size
    fi
    sleep 0.5  # Check size every 0.5 seconds
  done
)

# Notify user of completion
echo "Debian package build completed! The .deb file is located at $deb_file"
