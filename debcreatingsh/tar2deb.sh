#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get install tar wget build-essential imagemagick devscripts debhelper bc busybox -y
clear
# Edit the Export Variables in order for this file to work successfully
export TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"

while true; do
    read -p "Please enter the URL of the tar file: " TAR_URL
    if [[ -z "$TAR_URL" ]]; then
        echo "URL cannot be empty. Please enter a valid URL."
    elif [[ ! "$TAR_URL" =~ ^https?://[a-zA-Z0-9./-]+$ ]]; then
        echo "Invalid URL format. Please enter a valid URL."
    else
        clear
        echo "Valid URL. Grabbing download tar URL with wget."
        break
    fi
done

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

# Directory to store the downloaded file

# Create a temporary file for progress tracking
touch /tmp/wget_progress

# Start the download with wget and capture progress
echo "Downloading the file..."
start_time=$(date +%s)
wget -P ~/ --progress=dot "$TAR_URL" 2>&1 | tee /tmp/wget_progress >> /dev/null
echo "100" >> /tmp/wget_progress  # Ensure the progress is marked as 100% at the end

# Show the wget progress
show_wget_progress
wait $!

# Calculate the duration of the download
end_time=$(date +%s)
download_duration=$((end_time - start_time))
echo -e "\nDownload completed in ${download_duration}s."

# Export the path of the downloaded file as a variable using the specific command
tarfile=$(wget -P ~/ -nv $TAR_URL 2>&1 | tee /tmp/wget_progress | cut -d\" -f2 )
echo "Downloaded file: $tarfile"

# Clean up the wget progress file
rm /tmp/wget_progress

# Verify the tar file path
if [ ! -f "$tarfile" ]; then
  echo "Error: Tar file does not exist at $tarfile"
  exit 1
fi

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
    else
  done
}

# Create a temporary file for progress tracking
touch /tmp/tar_progress

# Prepare for tar extraction
echo "Extracting the tar file..."
start_time=$(date +%s)
total_files=$(tar -tf "$tarfile" | wc -l)

# Start the extraction with tar, capture progress, and export the tar directory
TAR_DIR=$(tar -xvf "$tarfile" -C ~/ | tee /tmp/tar_progress | cut -d / -f1 | uniq)
# Show the tar extraction progress
show_tar_progress
wait $!

# Calculate the duration of the extraction
end_time=$(date +%s)
extraction_duration=$((end_time - start_time))
echo -e "\nExtraction completed in ${extraction_duration}s."

# Export the directory created from the extracted tar file
echo "$TAR_DIR"
# Clean up the temporary tar progress files
rm /tmp/tar_progress 

is_letter() {
    [[ "$1" =~ ^[Aa-zZ2]+$ ]];
}

# Prompt user for input
while true; do
    read -p "Please enter the name of your package: " PackageName
    if is_letter "$PackageName"; then
        clear
        echo "The name of your package is: $PackageName"
        read -p "do you want to change the name of your package? (yes/no) " yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debpackagenameprompt.sh
    elif [ "$yesorno" = no ]; then
    clear
    echo "not changing name of package"
    clear
    break
    fi
    else
        echo "Invalid input. Please enter a valid letter."
    fi
done
is_number() {
    [[ "$1" =~ ^[0-9+\.]+$ ]];
}

# Prompt user for input
while true; do
    read -p "Please enter a Version for your package: " Version
    if is_number "$Version"; then
        clear
        echo "The version of your package is: $Version"
        read -p "do you want to change the version of your package? (yes/no) " yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debversionprompt.sh
    elif [ "$yesorno" = no ]; then
    clear
    echo "not changing package version"
    clear
    break
    else
    echo "Not a number."
    fi
        break
    else
        echo "Invalid input. Please enter a valid number."
    fi
done
export Name="$PackageName"
export V="$Version"
export DEB_DIR="$Name-$Version"
mkdir ~/$DEB_DIR/
mkdir -p ~/$DEB_DIR/DEBIAN
clear
echo -e "creating maintainer for ~/$DEB_DIR/DEBIAN/control file"
# Function to validate and create full name
create_full_name() {
  local input=("$@")
  local first_name=""
  local last_name=""
  local valid_input=true

  # Validate and separate first and last name
  for word in "${input[@]}"; do
    if [[ ! "$word" =~ [0-9] ]]; then
      if [ -z "$first_name" ]; then
        first_name="$word"
      elif [ -z "$last_name" ]; then
        last_name="$word"
      fi
    else
      valid_input=false
      break
    fi
  done

  if [ "$valid_input" = true ] && [ -n "$first_name" ] && [ -n "$last_name" ]; then
    full_name="$first_name $last_name"
    echo "Valid full name: $full_name"
    export Maintainer="$full_name"
  else
    echo "Invalid input. Please enter only letters and spaces for the first and last name."
  fi
}

# Prompt user for input
while true; do
    read -p "Please enter your name or some elses name as the maintainer for the package: " -a Maintainer
    if IFS=" " create_full_name "${Maintainer[@]}"; then
        clear
        read -p "The Maintainer of your package is: $Maintainer is that correct? if not do you want change it? (yes/no) " yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debmaintainerprompt.sh
    elif [ "$yesorno" = no ]; then
    clear
    echo "not changing package maintainer name"
    break
    else
    echo "Not a letter."
    fi
        break
    else
        echo "Invalid input. Please enter a valid letter."
    fi
done
clear
read -p "what is your package about?; or just type anything: " Description
cat << EOF >~/$DEB_DIR/DEBIAN/control
Package: $PackageName
Version: $Version
Section: base
Priority: optional
Architecture: all
Maintainer: $Name
Description: $Description

EOF
mkdir -p ~/$DEB_DIR/usr/bin/

# Export the subdirectory as a variable

# Export the filenames as a variable
export FILES_MOVED="${exported_files[*]}"
echo "Exported files: $FILES_MOVED"

mkdir -p ~/$DEB_DIR/usr/lib/$TAR_DIR
mkdir -p ~/$DEB_DIR/usr/lib/
mkdir -p ~/$DEB_DIR/usr/share/applications/
echo -e "copying executable files to $DEB_DIR"
echo "copying image files to $DEB_DIR"
cp -r ~/$TAR_DIR/* ~/$DEB_DIR/usr/lib/$TAR_DIR/
cp -r ~/$TAR_DIR/lib*.so ~/$DEB_DIR/usr/lib/
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
export source_dir="$subdirectory"
#!/bin/bash

# Function to get image dimensions
get_dimensions() {
    identify -format "%wx%h" "$1" 2>/dev/null
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

# Prompt for source directory

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
done < <(find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

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

# Prompt to rename files
read -p "Do you want to rename all images by dimension (yes/no)? " rename_all
if [[ "$rename_all" == "yes" ]]; then
    for dimensions in "${!image_groups[@]}"; do
        dimension_path="${dest_dirs[$dimensions]}"
        for file in "$dimension_path/"*; do
            mv "$file" "$dimension_path/$dimensions-$(basename "$file")"
        done
    done
else
    read -p "Do you want to rename each image manually by dimension (yes/no)? " rename_each
    if [[ "$rename_each" == "yes" ]]; then
        for dimensions in "${!image_groups[@]}"; do
            dimension_path="${dest_dirs[$dimensions]}"
            for file in "$dimension_path/"*; do
                read -p "Enter new name for $file (excluding file extension): " new_name
                mv "$file" "$dimension_path/$new_name.${file##*.}"
            done
        done
    fi
fi

dpkg-deb --build ~/$DEB_DIR