TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"
wget -P ~/ $TAR_URL && tar -xvf ~/zen.linux-x86_64.tar.xz -C ~/
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
ls48x48() {
# Directory to check
directory="$HOME/$TAR_DIR/usr/share/icons/hicolor/48x48/apps"


# Count the number of files in the directory
file_count=$(ls -1 "$directory" | wc -l)

# Get the filenames and export as a variable
file_list=$(ls -1 "$directory")

# Create a numeric list file with filenames next to it
numeric_list_file="$directory/numeric_list.txt"
cat <<EOL > "$numeric_list_file"
$(ls -1 /usr/share/icons/hicolor | nl)
EOL
numberic48x48=$(cat -v $numeric_list_file)
# Display the numeric list file path
echo "$numberic48x48"
}
ls48x48exclude() {

# Directory to check
directory="$HOME/usr/share/icons/hicolor/"

# Directories to exclude
exclude_dirs=("symbolic" "scalable" "index.theme")

# Generate exclusion pattern
exclude_pattern=$(printf "|%s" "${exclude_dirs[@]}")
exclude_pattern=${exclude_pattern:1}

# Create a numeric list file with filenames next to it using `cat` here document
numeric_list_file="$HOME/$TAR_DIR/usr/share/Tar2DebLists/hicolor.txt"
mkdir -p $numeric_list_file
cat <<EOL > "$numeric_list_file"
Number of files: $(ls -1 "$directory" | grep -Ev "($exclude_pattern)" | wc -l)
File List:
$(ls -1 "$directory" | grep -Ev "($exclude_pattern)" | nl)
EOL

# Display the numeric list file path
cat -v $numeric_list_file
}
ls48x48

read -p "do you want to pick a file from a directory in the numberic list to rename: (yes/no) " yesorno48x48
ls48x48exclude
if [[ $yesorno48x48 = " 1 "]]
echo "you picked 48x48"
elif

else
echo "not a number"
