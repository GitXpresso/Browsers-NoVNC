#!/bin/bash
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

# Directory to search within

# Destination directories for different dimensions
declare -A dest_dirs=(
  ["8x8"]="/path/to/dest/8x8"
  ["16x16"]="/path/to/dest/16x16"
  ["22x22"]="/path/to/dest/22x22"
  ["24x24"]="/path/to/dest/24x24"
  ["32x32"]="/path/to/dest/32x32"
  ["36x36"]="/path/to/dest/36x36"
  ["42x42"]="/path/to/dest/42x42"
  ["48x48"]="/path/to/dest/48x48"
  ["64x64"]="/path/to/dest/64x64"
  ["72x72"]="/path/to/dest/72x72"
  ["96x96"]="/path/to/dest/96x96"
  ["128x128"]="/path/to/dest/128x128"
  ["192x192"]="/path/to/dest/192x192"
  ["256x256"]="/path/to/dest/256x256"
  ["512x512"]="/path/to/dest/512x512"
  ["unlisted"]="/path/to/dest/unlisted"
)

# Create the destination directories if they don't exist
for dir in "${dest_dirs[@]}"; do
  mkdir -p "$dir"
done

# Find image files by dimension and move them to the appropriate directory
find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" \) | while read -r file; do
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
  echo "Files have not been renamed