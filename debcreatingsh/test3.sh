#!/bin/bash
sudo apt install imagemagick -y
# Directory to search within
search_dir="$HOME/$TAR_DIR"
# File type to search for
# Find subdirectories containing the specific file type
subdir=$(find "$search_dir" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.ico" -o -name "*.jpeg" \) -exec dirname {} \; | sort -u)

# Export the subdirectory paths as a variable
export SUBDIRS="$subdir"
IFS=' ' read -r subdir1 subdir2 subdir3 subdir4 <<< "$SUBDIRS"

# Export the variables
# Directory containing the images
source_dir="~/$subdir1/"
# Directory to move the matched images to
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/"
# Desired dimensions
target_width=48
target_height=48

# Create the destination directory if it doesn't exist
mkdir -p "$dest_dir"

# Iterate through image files in the source directory
for image in "$source_dir"/*.{jpg,jpeg,png}; do
  if [ -f "$image" ]; then
    # Get the dimensions of the image
    dimensions=$(identify -format "%wx%h" "$image")
    width=$(echo $dimensions | cut -d'x' -f1)
    height=$(echo $dimensions | cut -d'x' -f2)

    # Check if the image has the target dimensions
    if [ "$width" -eq "$target_width" ] && [ "$height" -eq "$target_height" ]; then
      # Move the image to the destination directory
      mv "$image" "$dest_dir"
    fi
  fi
done

echo "Script completed successfully!"
