#!/bin/bash

# Reset color
NoColor=$(tput sgr0)
# Define colors using tput
Black=$(tput setaf 0)
Red=$(tput setaf 1)
Green=$(tput setaf 2)
Yellow=$(tput setaf 3)
Blue=$(tput setaf 4)
Purple=$(tput setaf 5)
Cyan=$(tput setaf 6)
White=$(tput setaf 7)
BBlack=$(tput setaf 0; tput bold)
BRed=$(tput setaf 1; tput bold)
BGreen=$(tput setaf 2; tput bold)
BYellow=$(tput setaf 3; tput bold)
BBlue=$(tput setaf 4; tput bold)
BPurple=$(tput setaf 5; tput bold)
BCyan=$(tput setaf 6; tput bold)
BWhite=$(tput setaf 7; tput bold)
echo -e "${BBlack}installing required packages${NoColor}"
# Install Zen Browser to create .deb package
sudo apt-get install tar wget build-essential imagemagick devscripts debhelper bc busybox -y
clear
# Edit the Export Variables in order for this file to work successfully
export TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"

while true; do
    read -p "Please enter the URL of the tar file: " TAR_URL
    if [[ -z "$TAR_URL" ]]; then
        echo "URL cannot be empty. Please enter a valid URL."
    elif [[ ! "$TAR_URL" =~ ^https?://[a-zA-Z0-9./_-]+$ ]]; then
        echo "Invalid URL format. Please enter a valid URL."
    else
        clear
        echo "Valid URL. Grabbing download tar URL with wget."
        break
    fi
done

tarfile=$(wget -P ~/ -nv $TAR_URL 2>&1 | cut -d\" -f2 ) && TAR_DIR=$(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq) 
rm -f $tarfile

is_letter() {
    [[ "$1" =~ ^[Aa-zZ2]+$ ]];
}

# Prompt user for input
while true; do
    read -p "Please enter the name of your package: " PackageName
    if is_letter "$PackageName"; then
        clear
        echo "The name of your package is: ${BBlack}$PackageName${NoColor}"
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
        read -p "The Maintainer of your package is: ${BBlack}$Maintainer${NoColor} is that correct? if not do you want change it? (yes/no) " yesorno
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
find $HOME/palemoon -type f -exec file {} + | grep -i 'executable' | grep -vi 'binary' | cut -d: -f1 | grep -v -E 'glxtest|updater|vaapitest|pingsender|plugin-container|run-mozilla.sh' | while read -r file; do busybox ln -s "$file" $HOME/palemoon-33.5.1/usr/bin/; done

# Specify the directories to check
CHECK_DIR1="$HOME/palemoon"
CHECK_DIR2="$HOME/"

# Specify the word to search for in the second directory
SPECIFIC_WORD="your-specific-word"

# Check if the first directory exists
if [ -d "$CHECK_DIR1" ]; then
    echo "Directory found: $CHECK_DIR1. Installing required packages..."

    # Update package lists and install the required packages
    sudo apt update
    sudo apt install -y libdbus-glib-1-2
    echo "Packages installed successfully."
fi

# Check if the second directory exists
if [ -d "$CHECK_DIR2" ]; then
    # Check if any files in the second directory contain the specific word
    if grep -Rl "$SPECIFIC_WORD" "$CHECK_DIR2" > /dev/null 2>&1; then
        echo "Directory found: $CHECK_DIR2. The word '$SPECIFIC_WORD' is found in its files."

        # If the word is found, perform the desired action (e.g., install packages)
        echo "Installing additional required packages for directory containing '$SPECIFIC_WORD'..."

        # You can install different packages here if needed
        sudo apt install -y some-other-package

        echo "Additional packages installed successfully."
    else
        echo "Directory found: $CHECK_DIR2, but the word '$SPECIFIC_WORD' is not found in any of its files. No additional action taken."
    fi
else
    echo "Second directory not found: $CHECK_DIR2. No packages installed."
fi

# Display a message indicating the operation is complete
echo "removed uneeded files: $files_to_remove" 
mkdir -p ~/$DEB_DIR/usr/lib/$TAR_DIR
mkdir -p ~/$DEB_DIR/usr/lib/
mkdir -p ~/$DEB_DIR/usr/share/applications/
echo -e "copying executable files to $DEB_DIR"
echo "copying image files to $DEB_DIR"
cp -r ~/$TAR_DIR/* ~/$DEB_DIR/usr/lib/$TAR_DIR/
cp -r ~/$TAR_DIR/lib*.so ~/$DEB_DIR/usr/lib/
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

# Destination directories for different dimensions
declare -A dest_dirs=(
  ["8x8"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/8x8/apps"
  ["16x16"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/16x16/apps"
  ["22x22"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/22x22/apps"
  ["24x24"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/24x24/apps"
  ["32x32"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/32x32/apps"
  ["36x36"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/36x36/apps"
  ["42x42"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/42x42/apps"
  ["48x48"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/48x48/apps"
  ["64x64"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/64x64/apps"
  ["72x72"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/72x72/apps"
  ["96x96"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/96x96/apps"
  ["128x128"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/128x128/apps"
  ["192x192"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/192x192/apps"
  ["256x256"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/256x256/apps"
  ["512x512"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/512x512/apps"
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
        image_groups["$dimensions"]+="$file"$'\n'
    fi
done < <(find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

# Move images to destination directories
for dimensions in "${!image_groups[@]}"; do
    if [[ -n "${dest_dirs[$dimensions]}" ]]; then
        dimension_path="${dest_dirs[$dimensions]}"
    else
        dimension_path="${dest_dirs["unlisted"]}"
    fi
    while IFS= read -r file; do
        [[ -f "$file" ]] && mv "$file" "$dimension_path/"
    done <<< "${image_groups[$dimensions]}"
done

# Prompt user if they want to rename all files in all subdirectories
read -p "Do you want to rename all files in subdirectories into one name? (yes/no): " rename_all

if [[ "$rename_all" == "yes" ]]; then
    read -p "Enter the base name for all files: " base_name
    counter=1

    for dir in "${dest_dirs[@]}"; do
        for file in "$dir"/*; do
            if [[ -f "$file" ]]; then
                extension="${file##*.}"
                mv "$file" "$dir/$base_name_$counter.$extension"
                ((counter++))
            fi
        done
    done
    echo "All files renamed successfully."
    exit 0
fi

# If user said no, ask if they want to rename individual files
read -p "Do you want to rename specific files instead? (yes/no): " rename_individual

if [[ "$rename_individual" == "yes" ]]; then
    # Generate a single numerical list of all files across dimension folders
    echo "Creating numerical list of all files:"
    files_list=()
    file_paths=()
    counter=1

    # Iterate over all dimension directories and collect files
    for dimension_path in "${dest_dirs[@]}"; do
        for file in "$dimension_path"/*; do
            if [[ -f "$file" ]]; then
                files_list+=("$(basename "$file")")
                file_paths+=("$file")  # Store full path
                echo "$counter. $(basename "$file") (in $(basename "$dimension_path"))"
                ((counter++))
            fi
        done
    done

    # Ask the user to select files by number
    while true; do
      read -p "Enter the numbers of the files you want to rename (comma-separated, or 'q' to quit): " selected_numbers
      if [[ "$selected_numbers" == "q" ]]; then
        break
      fi

      # Convert input into an array
      IFS=',' read -r -a selected_array <<< "$selected_numbers"

      for selected_number in "${selected_array[@]}"; do
        # Trim whitespace
        selected_number=$(echo "$selected_number" | xargs)

        # Validate number selection
        if [[ "$selected_number" =~ ^[0-9]+$ ]] && [[ "$selected_number" -ge 1 && "$selected_number" -le ${#files_list[@]} ]]; then
          selected_file="${file_paths[$selected_number-1]}"
          selected_dir=$(dirname "$selected_file")
          read -p "Enter the new name for '$(basename "$selected_file")' (without extension): " new_name
          extension="${selected_file##*.}"
          mv "$selected_file" "$selected_dir/$new_name.$extension"
          echo "File renamed to $new_name.$extension"
        else
          echo "Invalid selection: $selected_number. Please choose a valid number."
        fi
      done
    done
fi
dpkg-deb --build ~/$DEB_DIR

# Define colors
NoColor=$(tput sgr0)
BWhite=$(tput setaf 7; tput bold)

# Sample deb file for demonstration
debfile="$HOME/$DEB_DIR.deb"  # Replace with actual variable if needed

# Function to check if the input contains a dot (.)
validate_filename() {
    if [[ "$1" == *"."* ]]; then
        echo "Error: Filenames cannot contain the '.' character."
        return 1
    else
        return 0
    fi
}

# Loop for user confirmation and renaming
while true; do
    read -p "Do you want to rename this ${BWhite}$debfile${NoColor} file? (yes/no): " yesorno

    if [[ "$yesorno" == "yes" ]]; then
        while true; do
            # Ask for the new filename (without extension)
            read -p "What do you want the filename to be? " filerename

            # Validate the filename (no dots allowed)
            validate_filename "$filerename"
            if [[ $? -eq 0 ]]; then
                # Ensure no extension is included
                new_filename="${filerename%.deb}"  # Remove any .deb if accidentally added
                mv "$debfile" "$HOME/$new_filename.deb"
                echo "File renamed to $new_filename.deb"
                break
            fi
        done
        break

    elif [[ "$yesorno" == "no" ]]; then
        read -p "Are you sure you don't want to change the filename of your choice? (yes/no): " yesorno2
        
        if [[ "$yesorno2" == "no" ]]; then
            while true; do
                # Ask for the new filename (without extension)
                read -p "What do you want the filename to be? " filerename2

                # Validate the filename (no dots allowed)
                validate_filename "$filerename2"
                if [[ $? -eq 0 ]]; then
                    # Ensure no extension is included
                    new_filename2="${filerename2%.deb}"  # Remove any .deb if accidentally added
                    mv "$debfile" "$HOME/$new_filename2.deb"
                    echo "File renamed to $new_filename2.deb"
                    break
                fi
            done
            break
        elif [[ "$yesorno2" == "yes" ]]; then
            echo "Not changing filename."
            break
        fi
    fi
done
