#!/bin/bash

search_dir="$HOME/zen/"
file_types="*.jpg *.jpeg *.png *.bmp"

# Debugging: Print the search directory and file types
echo "Search directory: $search_dir"
echo "File types: $file_types"

# Find subdirectory containing more than one image file
subdirectory=$(find "$search_dir" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.bmp" \) -printf '%h\n' | sort | uniq -c | awk '$1 > 1 {print $2; exit}')

# Check if subdirectory is found
if [ -z "$subdirectory" ]; then
  echo "No subdirectory found containing more than one image file."
  exit 1
fi

# Export the subdirectory as a variable
export search_dir="$subdirectory"

# Debugging: Print the found subdirectory
echo "Subdirectory found: $search_dir"
DEB_DIR="~/zen20/"
# Function to prompt user for renaming all files
rename_all_files() {
  local dir="$1"
  for file in "$dir"/*; do
    if [[ -f "$file" ]]; then
      base_name=$(basename "$file")
      new_name="$dir/renamed_$base_name"
      mv -f "$file" "$new_name"
    fi
  done
}

# Function to prompt user for renaming each file manually
rename_each_file() {
  local file="$1"
  read -p "Do you want to rename $file? (y/n): " response
  if [[ "$response" =~ ^[Yy]$ ]]; then
    read -p "Enter the new base name for the file (without extension): " new_base_name
    local extension="${file##*.}"
    new_filename="$(dirname "$file")/${new_base_name}.${extension}"
    mv -f "$file" "$new_filename"
    echo "Renamed $file to $new_filename"
  fi
}

# Destination directories for different dimensions
declare -A dest_dirs=(
  ["8x8"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/8x8/apps/"
  ["16x16"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/16x16/apps/"
  ["22x22"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/22x22/apps/"
  ["24x24"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/24x24/apps/"
  ["32x32"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/32x32/apps/"
  ["36x36"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/36x36/apps/"
  ["42x42"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/42x42/apps/"
  ["48x48"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/"
  ["64x64"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/64x64/apps/"
  ["72x72"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/72x72/apps/"
  ["96x96"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/96x96/apps/"
  ["128x128"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/128x128/apps/"
  ["192x192"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/192x192/apps/"
  ["256x256"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/256x256/apps/"
  ["512x512"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/512x512/apps/"
  ["unlisted"]="$HOME/$DEB_DIR/usr/share/unlisted_dimensions"
)

# Create the destination directories if they don't exist
for dir in "${dest_dirs[@]}"; do
  mkdir -p "$dir"
done

# Find image files by dimension and move them to the appropriate directory
find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.bmp" \) | while read -r file; do
  if identify "$file" > /dev/null 2>&1; then
    dimensions=$(identify -format "%wx%h" "$file")
    dest_dir="${dest_dirs[$dimensions]:-${dest_dirs["unlisted"]}}"
    mv "$file" "$dest_dir"
    echo "Moved $file to $dest_dir"
  fi
done

# Prompt the user for renaming the files
echo "Do you want to rename the files (excluding the file extensions)? (yes/no)"
read answer

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
  echo "Files have not been renamed."
fi
