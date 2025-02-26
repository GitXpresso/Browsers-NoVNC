#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get install tar wget build-essential imagemagick devscripts debhelper bc busybox -y
clear
# Edit the Export Variables in order for this file to work successfully
export TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"
read -p "Please enter the url of the tar file: " TAR_URL
if [[ ! "${TAR_URL}" == *[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\.]* ]]; then
    echo "Invalid URL that is NOT allowed."
else
    clear
    echo "Valid URL grabbing download tar url with wget"
    clear
fi


# URL of the tar file to download

# Function to show a loading bar
show_loading_bar() {
  local duration=$1
  bar="#########################"
  empty_bar="........................."
  steps=30
  step_time=$(echo "$duration / $steps" | bc -l)

  for ((i = 1; i <= steps; i++)); do
    printf "\r[%-30s] %d%%" "${bar:0:i}${empty_bar:i}" $((i * 100 / steps))
    sleep "$step_time"
  done
  echo -e "\nOperation complete!"
}

# Directory to store the downloaded file
# URL of the tar file
# Start the download and measure the time
echo "Downloading the file..."
start_time=$(date +%s)
tarfile=$(wget -P ~/ -nv "$TAR_URL" 2>&1 | cut -d\" -f2)
end_time=$(date +%s)

# Calculate the duration of the download
duration=$((end_time - start_time))

# Check if the file was downloaded
if [ -z "$tarfile" ]; then
  echo "Download failed. Check the Download URL your pasted."
  exit 1
fi

# Start the loading bar in the background
show_loading_bar "$duration" &

# Extract the tar file
TAR_DIR=$(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq)

# Wait for the loading bar to finish
wait

# Remove the tar file
sudo rm -f "$tarfile"

# Output the extracted directory
echo "Extracted directory: $TAR_DIR"
# Function to check if input is a number
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
    else
    echo "Not a name."
    fi
        break
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
        echo "The Maintainer of your package is: $Maintainer"
        read -p "do you want to change the maintainer name of your package? (yes/no) " yesorno
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
#!/bin/bash
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
export src_dir="$subdirectory"


# Define the destination directory
dest_dir="$HOME/$DEB_DIR/usr/bin/"

# Ensure the destination directory exists

# Print the variables to the user
echo "Source directory: $src_dir"
echo "Destination directory: $dest_dir"

# Find executable files excluding binary files and store them in an array
mapfile -t executable_files < <(find "$src_dir" -type f -executable -exec sh -c 'file -b "$1" | grep -q "text" && echo "$1"' _ {} \;)

# Move the files to the destination directory
for file in "${executable_files[@]}"; do
  busybox ln -s "$file" "$dest_dir"
done

# List the files moved and export as a variable
echo "Files moved to $dest_dir:"
for file in "${executable_files[@]}"; do
  base_name=$(basename "$file")
  new_path="$dest_dir/$base_name"
  echo "$new_path"
  exported_files+=("$new_path")
done

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

# Define the source directory

# Define the destination directories for specific dimensions
dest_dir_8x8="$HOME/$DEB_DIR/usr/share/icons/hicolor/8x8/apps"
dest_dir_16x16="$HOME/$DEB_DIR/usr/share/icons/hicolor/16x16/apps"
dest_dir_22x22="$HOME/$DEB_DIR/usr/share/icons/hicolor/22x22/apps"
dest_dir_24x24="$HOME/$DEB_DIR/usr/share/icons/hicolor/24x24/apps"
dest_dir_32x32="$HOME/$DEB_DIR/usr/share/icons/hicolor/32x32/apps"
dest_dir_36x36="$HOME/$DEB_DIR/usr/share/icons/hicolor/36x36/apps"
dest_dir_42x42="$HOME/$DEB_DIR/usr/share/icons/hicolor/42x42/apps"
dest_dir_48x48="$HOME/$DEB_DIR/usr/share/icons/hicolor/48x48/apps"
dest_dir_64x64="$HOME/$DEB_DIR/usr/share/icons/hicolor/64x64/apps"
dest_dir_72x72="$HOME/$DEB_DIR/usr/share/icons/hicolor/72x72/apps"
dest_dir_96x96="$HOME/$DEB_DIR/usr/share/icons/hicolor/96x96/apps"
dest_dir_128x128="$HOME/$DEB_DIR/usr/share/icons/hicolor/128x128/apps"
dest_dir_192x192="$HOME/$DEB_DIR/usr/share/icons/hicolor/192x192/apps"
dest_dir_256x256="$HOME/$DEB_DIR/usr/share/icons/hicolor/256x256/apps"
dest_dir_512x512="$HOME/$DEB_DIR/usr/share/icons/hicolor/512x512/apps"
dest_dir_unlisted="$HOME/$DEB_DIR/usr/share/unlisted_images"
# Create destination directories if they do not exist
mkdir -p "$dest_dir_unlisted"
mkdir -p "$dest_dir_8x8" "$dest_dir_16x16" "$dest_dir_22x22" "$dest_dir_24x24" "$dest_dir_32x32" "$dest_dir_36x36" "$dest_dir_42x42" "$dest_dir_48x48""$dest_dir_64x64" "$dest_dir_72x72" "$dest_dir_96x96" "$dest_dir_128x128" "$dest_dir_192x192" "$dest_dir_256x256" "$dest_dir_512x512"
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

# Move the files based on their dimensions
for file in "$subdirectory"/*; do
    if [[ -f "$file" ]]; then
        if identify "$file" > /dev/null 2>&1; then
            dimensions=$(identify -format "%wx%h" "$file")
            case $dimensions in
                "8x8")
                    cp -r "$file" "$dest_dir_8x8"
                    ;;
                "16x16")
                    cp -r "$file" "$dest_dir_16x16"
                    ;;
                "22x22")
                    cp -r "$file" "$dest_dir_22x22"
                    ;;
                "24x24")
                    cp -r "$file" "$dest_dir_24x24"
                    ;;
                "32x32")
                    cp -r "$file" "$dest_dir_32x32"
                    ;;
                "36x36")
                    cp -r "$file" "$dest_dir_36x36"
                    ;;
                "42x42")
                    cp -r "$file" "$dest_dir_42x42"
                    ;;
                "48x48")
                    cp -r "$file" "$dest_dir_48x48"
                    ;;
                "64x64")
                    cp -r "$file" "$dest_dir_64x64"
                    ;;
                "72x72")
                    cp -r "$file" "$dest_dir_72x72"
                    ;;
                "96x96")
                    cp -r "$file" "$dest_dir_96x96"
                    ;;
                "128x128")
                    cp -r "$file" "$dest_dir_128x128"
                    ;;
                "192x192")
                    cp -r "$file" "$dest_dir_192x192"
                    ;;
                "256x256")
                    cp -r "$file" "$dest_dir_256x256"
                    ;;
                "512x512")
                    cp -r "$file" "$dest_dir_22x22"
                    ;;
                *)
                    mv "$file" "$dest_dir_unlisted"
                    ;;
            esac
        fi
    fi
done

# List the files moved
echo "Files moved to respective directories based on their dimensions."

# Prompt the user for renaming the files
echo "Do you want to rename the files (excluding the file extensions)? (yes/no)"
read answer

if [[ "$answer" == "yes" ]]; then
    echo "Renaming files..."
    for dir in "$dest_dir_8x8" "$dest_dir_16x16" "$dest_dir_22x22" "$dest_dir_24x24" "$dest_dir_32x32" "$dest_dir_36x36" "$dest_dir_42x42" "$dest_dir_48x48""$dest_dir_64x64" "$dest_dir_72x72" "$dest_dir_96x96" "$dest_dir_128x128" "$dest_dir_192x192" "$dest_dir_256x256" "$dest_dir_512x512" "$dest_dir_unlisted"; do
        for file in "$dir"/*; do
            if [[ -f "$file" ]]; then
                base_name=$(basename "$file")
                new_name="$dir/renamed_$base_name"
                mv -f "$file" "$new_name"
            fi
        done
    done
    echo "Files have been renamed."
else
    echo "Files have not been renamed."
fi
dpkg-deb --build ~/$DEB_DIR