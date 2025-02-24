
#!/bin/bash
sudo apt install imagemagick busybox -y
# Directory to search for subdirectories
search_dir="$HOME/$TAR_DIR/"

# Image file types to search for
file_types="*.jpg *.jpeg *.png *.bmp"

# Find subdirectory containing more than one image file
subdirectory=$(find "$search_dir" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp" \) -printf '%h\n' | sort | uniq -c | awk '$1 > 1 {print $2; exit}')

# Check if subdirectory is found
if [ -z "$subdirectory" ]; then
  echo "No subdirectory found containing more than one image file."
  exit 1
fi

# Export the subdirectory as a variable
export search_dir="$subdirectory"

# Directory to search for image files
# Target dimensions
target_width=48
target_height=48

# Destination directory
dest_dir="$HOME/$DEB_DIR"

# Find image by dimension
image_file=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file" "$dest_dir"
echo $image_file
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file##*.}"
  mv "$dest_dir/$(basename "$image_file")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file")"
fi
