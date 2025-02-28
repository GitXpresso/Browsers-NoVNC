TAR_DIR="zen"
search_dir="$HOME/$TAR_DIR/"
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
export source_dir="$subdirectory"
#!/bin/bash

# Function to get image dimensions
get_dimensions() {
    identify -format "%wx%h" "$1" 2>/dev/null
}

# Source directory (replace this variable with the actual source directory path)
DEB_DIR="zen2deb-1.0.0"
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

# Find and group images by dimensions
declare -A image_groups
while IFS= read -r -d '' file; do
    dimensions=$(get_dimensions "$file")
    if [ -n "$dimensions" ]; then
        if [[ -n "${dest_dirs[$dimensions]}" ]]; then
            dest_dir="${dest_dirs[$dimensions]}"
        else
            dest_dir="${dest_dirs["unlisted"]}"
        fi
        image_groups["$dimensions"]+="$file "
    fi
done < <(find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -print0)

# Move images to destination directories
for dimensions in "${!image_groups[@]}"; do
    if [[ -n "${dest_dirs[$dimensions]}" ]]; then
        dimension_path="${dest_dirs[$dimensions]}"
    else
        dimension_path="${dest_dirs["unlisted"]}"
    fi
    for file in ${image_groups[$dimensions]}; do
        mv "$file" "$dimension_path/"
    done
done
echo "$file"
