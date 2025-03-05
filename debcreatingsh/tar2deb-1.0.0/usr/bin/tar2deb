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
sudo apt update
sudo apt-get install tar wget build-essential imagemagick devscripts debhelper curl bash busybox libasound-dev -y
clear
# Edit the Export Variables in order for this file to work successfully
#!/bin/bash

# Function to check if the tar file can be extracted
check_tar_validity() {
    # Try extracting the tar file without actually extracting it
    tar -tf "$1" &>/dev/null
    return $?  # Return the result of tar command
}

# Function for loading animation
# Prompt the user for the URL of the tar file
while true; do
    read -p "Please enter the URL of the tar file: " TAR_URL
    
    # Validate the URL
    if [[ -z "$TAR_URL" ]]; then
        echo "URL cannot be empty. Please enter a valid URL."
    elif [[ ! "$TAR_URL" =~ ^https?://[a-zA-Z0-9./_-]+$ ]]; then
        echo "Invalid URL format. Please enter a valid URL."
    else
        clear
        echo "Valid URL. Grabbing download tar URL with wget."
        clear
        break
    fi
done

# Get the filename and destination path
FILENAME=$(basename "$TAR_URL")
DEST_FILE="$HOME/$FILENAME"

# Download the file using wget
wget -P ~/ -nv --progress=bar:force "$TAR_URL" 2>&1 | tee /dev/null | sed -u 's/\([0-9]*\)%/\1%/' | awk '{print "\rDownloading: "$0; fflush();}' > /dev/null &
pid=$!
spin='-\|/'
i=0
while kill -0 $pid 2>/dev/null; do
    i=$(( (i+1) %4 ))
    printf "\rDownloading Tar file using wget...${spin:$i:1}"
    sleep 0.1
done
# Call loading animation in the background
# Check if the tar file is valid before proceeding
if ! check_tar_validity "$DEST_FILE"; then
    echo "Error: The downloaded file is not a valid tar file. run tar2deb again and try again with a valid url, Exiting."
    exit 1
fi

# Extract the tar file if it's valid
TAR_DIR=$(tar -xvf ~/downloads/zen.linux-x86_64.tar.xz -C ~/ | cut -d / -f1 | uniq) &
pid=$!

spin='-\|/'
i=0
while kill -0 $pid 2>/dev/null; do
    i=$(( (i+1) %4 ))
    clear
    printf "\rExtracting Tar file... ${spin:$i:1}"
    sleep 0.1
done
export tarfile="$DEST_FILE"

# Output the downloaded and extracted file paths

# Clean up by removing the tar file
rm -rf "$DEST_FILE"
printf "\nExtraction complete!\n"
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
        echo "The version of your package is: ${BBlack}$Version${NoColor}"
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
find $HOME/$TAR_DIR -type f -exec file {} + | grep -i 'executable' | grep -vi 'binary' | cut -d: -f1 | grep -v -E 'glxtest|updater|vaapitest|pingsender|plugin-container|run-mozilla.sh|*.py|blender-softwaregl|blender-system-info.sh|blender-thumbnailer'| while read -r file; do busybox ln -s "$file" $HOME/$DEB_DIR/usr/bin/; done
CHECK_DIR1="$HOME/palemoon*"
CHECK_DIR2="$HOME/basilisk*"

# Specify the word to search for in the second directory

# Check if the first directory exists
if [ -d "$CHECK_DIR1" ]; then
    echo "Directory found: $CHECK_DIR1. Installing required packages..."

    # Update package lists and install the required packages
    sudo apt update
    sudo apt install -y libgtk-3-0 libdbus-glib-1-2 libstdc++6 libx11-6 libx11-xcb1 yaru-theme-gtk yaru-theme-icon yaru-theme-sound
    echo "Packages installed successfully."
fi 
# Check if the second directory exists
if [ -d "$CHECK_DIR2" ]; then
    # Check if any files in the second directory contain the specific word
        sudo apt install -y libgtk-3-0 libdbus-glib-1-2 libstdc++6 libx11-6 libx11-xcb1 yaru-theme-gtk yaru-theme-icon yaru-theme-sound

        echo "Additional packages installed successfully."
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
# Check if at least one directory matching ~/blender* exists
#!/bin/bash
# Define the main directory to search in
SEARCH_DIR="$HOME/$TAR_DIR/"

# Ensure the directory exists
if [ ! -d "$SEARCH_DIR" ]; then
    echo "Error: Directory $SEARCH_DIR does not exist."
    exit 1
fi

# Function to count binary files in a given directory
count_binaries() {
    find "$1" -maxdepth 1 -type f -exec file --mime {} + 2>/dev/null | 
    grep -E "application/x-executable|application/x-sharedlib" | 
    wc -l
}

# Check binaries in the main directory itself
MAIN_BIN_COUNT=$(count_binaries "$SEARCH_DIR")

# Find subdirectory with the most binaries
MOST_BINARIES_SUBDIR=""
MAX_BIN_COUNT=0

while IFS= read -r subdir; do
    BIN_COUNT=$(count_binaries "$subdir")

    if [ "$BIN_COUNT" -gt "$MAX_BIN_COUNT" ]; then
        MAX_BIN_COUNT="$BIN_COUNT"
        MOST_BINARIES_SUBDIR="$subdir"
    fi
done < <(find "$SEARCH_DIR" -mindepth 1 -maxdepth 1 -type d)

# Compare with the main directory
if [ "$MAIN_BIN_COUNT" -ge "$MAX_BIN_COUNT" ]; then
    MOST_BINARIES_SUBDIR="$SEARCH_DIR"
fi

# Export the result as a variable
export MOST_BINARIES_SUBDIR

# Output the result
cp ${MOST_BINARIES_SUBDIR}*.so $HOME/$DEB_DIR/usr/lib
search_dir="$HOME/$TAR_DIR/"
file_types="*.jpg *.jpeg *.png *.bmp *.svg"

# Debugging: Print the search directory and file types
echo "Search directory: $search_dir"
echo "File types: $file_types"

# Find subdirectory containing more than one image file
subdirectory=$(find "$search_dir" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.bmp" -o -name "*.svg" \) -printf '%h\n' | sort | uniq -c | awk '$1 > 1 {print $2; exit}')
# Check if subdirectory is found
if [ -z "$subdirectory" ]; then
  echo "No subdirectory found containing more than one image file."
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
done < <(find "$source_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.svg" \) -print0)

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
target_dir="$HOME/$TAR_DIR"
target_dir3="$HOME/$DEB_DIR/usr/share/applications"

# Find the most linked graphical executable
find_main_executable() {
    find "$target_dir" -type f -executable ! -name "*.sh" ! -name "*.so" | grep -v -E 'glxtest|updater|vaapitest|pingsender|plugin-container|run-mozilla.sh|*-bin' | while read -r file; do
        links=$(ldd "$file" 2>/dev/null | wc -l)
        echo "$links $file"
    done | sort -nr | awk 'NR==1{print $2}'
}

main_executable=$(find_main_executable)

# Check if an executable was found
if [[ -z "$main_executable" ]]; then
    echo "No graphical executable found."
    exit 1
fi

export MAIN_EXEC="$main_executable"
echo "Main executable found: $MAIN_EXEC"

# Check if a desktop file exists
desktop_file=$(find "$target_dir" -type f -name "*.desktop")

if [[ -z "$desktop_file" ]]; then
    read -p "${BBlack}No .desktop file found. Do you want to create one?${NoColor}(yes/no): " create_desktop
    if [[ "$create_desktop" == "yes" ]]; then
        # Ask if the user wants to choose an icon
        read -p "Do you want to pick an icon for the desktop file? (yes/no): " pick_icon
        icon_path=""

        if [[ "$pick_icon" == "yes" ]]; then
            echo "Creating a list of available images:"
            images_list=()
            file_paths=()
            counter=1

            # Loop through all directories in dest_dirs to list files
            for dimension_path in "${dest_dirs[@]}"; do
                for file in "$dimension_path"/*; do
                    if [[ -f "$file" ]]; then
                        images_list+=("$(basename "$file")")  # Store the image name
                        file_paths+=("$file")  # Store full path
                        echo "$counter. $(basename "$file") (in $(basename "$dimension_path"))"
                        ((counter++))
                    fi
                done
            done

            # Ask user to select an image
            if [[ ${#images_list[@]} -gt 0 ]]; then
                while true; do
                    read -p "Enter the number of the image you want to use as an icon (or 'q' to skip): " selected_number
                    if [[ "$selected_number" == "q" ]]; then
                        break
                    elif [[ "$selected_number" -ge 1 && "$selected_number" -le ${#images_list[@]} ]]; then
                        icon_path="${file_paths[$selected_number-1]}"  # Get the full path of the selected file
                        echo "Icon selected: $icon_path"
                        break
                    else
                        echo "Invalid selection. Try again."
                    fi
                done
            else
                echo "No image files found."
            fi
        fi

        # Create .desktop file
        desktop_file_path="$target_dir3/$(basename "$MAIN_EXEC" .sh).desktop"
        echo "[Desktop Entry]" > "$desktop_file_path"
        echo "Name=$(basename "$MAIN_EXEC")" >> "$desktop_file_path"
        echo "Version=$Version" >> "$desktop_file_path"
        echo "StartupWMClass=$MAIN_EXEC" >> "$desktop_file_path"
        echo "Type=Application" >> "$desktop_file_path"
        echo "Exec=$MAIN_EXEC" >> "$desktop_file_path"
        [[ -n "$icon_path" ]] && echo "Icon=$icon_path" >> "$desktop_file_path"
        echo "Terminal=false" >> "$desktop_file_path"
        chmod +x "$desktop_file_path"
        echo "Desktop file created at: $desktop_file_path"
    fi
fi
echo "${BBlack}Building Deb File${NoColor}"
dpkg-deb --build ~/$DEB_DIR
debfile="$HOME/$DEB_DIR.deb"
sudo chmod 644 $debfile
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
