#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get install tar wget build-essential imagemagick devscripts debhelper busybox -y
clear
# Edit the Export Variables in order for this file to work successfully
export TAR_URL="https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz"
export TAR_EXEC="zen"
export TAR_EXEC2="zen-bin"
read -p "Please enter the url of the tar file: " TAR_URL
if [[ ! "${TAR_URL}" == *[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\.]* ]]; then
    echo "Invalid URL that is NOT allowed."
else
    clear
    echo "Valid URL grabbing download tar url with wget"
    clear
fi


# URL of the tar file to download

# Download the file with wget and show a loading bar using echo
echo "Downloading the file..."
tarfile=$(wget -P ~/ -nv "$TAR_URL" 2>&1 | cut -d\" -f2)

# Check if the file was downloaded
if [ -z "$tarfile" ]; then
  echo "Download failed."
  exit 1
fi

# Display a loading bar
show_loading_bar() {
  bar="####################"
  empty_bar="...................."
  for i in {1..20}; do
    printf "\r[%-20s] %d%%" "${bar:0:i}${empty_bar:i}" $((i * 5))
    sleep 0.2
  done
  echo -e "\nOperation complete!"
}

# Start the loading bar
show_loading_bar &

# Extract the tar file
TAR_DIR=$(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq)

# Wait for the loading bar to finish
wait

# Remove the tar file
sudo rm -f $tarfile

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
mkdir -p ~/$DEB_DIR/usr/lib/$TAR_DIR
mkdir -p ~/$DEB_DIR/usr/lib/
mkdir -p ~/$DEB_DIR/usr/share/applications/
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/32x32/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/36x36/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/64x64/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/24x24/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/72x72/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/22x22/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/16x16/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/96x96/apps
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/42x42/apps
echo -e "copying executable files to $DEB_DIR"
echo "copying image files to $DEB_DIR"
cp -r ~/$TAR_DIR/* ~/$DEB_DIR/usr/lib/$TAR_DIR/
cp -r ~/$TAR_DIR/lib*.so ~/$DEB_DIR/usr/lib/
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
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/"

# Find image by dimension
image_file1=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file1" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file1" "$dest_dir"
echo $image_file1
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file1##*.}"
  mv "$dest_dir/$(basename "$image_file1")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file1")"
fi
done
# Directory to search for subdirectories
search_dir="$HOME/$DEB_DIR/"

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
target_width=128
target_height=128

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/128x128/apps/"

# Find image by dimension
image_file2=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file2" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file2" "$dest_dir"
echo $image_file2
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file2##*.}"
  mv "$dest_dir/$(basename "$image_file2")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
elif [ "$answer" == "no" ]; then
echo "not changing filename"
break 
else
  exported_filename="$(basename "$image_file2")"
fi
search_dir="$HOME/zen/"

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
target_width=32
target_height=32

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/32x32/apps/"

# Find image by dimension
image_file3=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file3" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file3" "$dest_dir"
echo $image_file3
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file3##*.}"
  mv "$dest_dir/$(basename "$image_file3")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file3")"
fi
done
# Directory to search for subdirectories
search_dir="$HOME/$DEB_DIR/"

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
target_width=36
target_height=36

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/36x36/apps/"

# Find image by dimension
image_file4=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file4" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file4" "$dest_dir"
echo $image_file4
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file4##*.}"
  mv "$dest_dir/$(basename "$image_file")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file4")"
fi
search_dir="$HOME/zen/"

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
target_width=16
target_height=16

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/16x16/apps/"

# Find image by dimension
image_file5=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file5" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file5" "$dest_dir"
echo $image_file5
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_fil5e##*.}"
  mv "$dest_dir/$(basename "$image_file5")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file5")"
fi
done
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
target_width=24
target_height=24

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/24x24/apps/"

# Find image by dimension
image_file6=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file6" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file6" "$dest_dir"
echo $image_file6
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file6##*.}"
  mv "$dest_dir/$(basename "$image_file6")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file6")"
fi
search_dir="$HOME/zen/"

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
target_width=96
target_height=96

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/96x96/apps/"

# Find image by dimension
image_file7=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file7" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file7" "$dest_dir"
echo $image_file7
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file7##*.}"
  mv "$dest_dir/$(basename "$image_file7")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file7")"
fi
done
# Directory to search for subdirectories
search_dir="$HOME/$DEB_DIR/"

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
target_width=72
target_height=72

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/72x72/apps/"

# Find image by dimension
image_file8=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file8" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file8" "$dest_dir"
echo $image_file8
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file8##*.}"
  mv "$dest_dir/$(basename "$image_file8")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file8")"
fi
search_dir="$HOME/zen/"

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
target_width=512
target_height=512

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/512x512/apps/"

# Find image by dimension
image_file9=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file9" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file9" "$dest_dir"
echo $image_file9
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file9##*.}"
  mv "$dest_dir/$(basename "$image_file9")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file9")"
fi
done
# Directory to search for subdirectories
search_dir="$HOME/$DEB_DIR/"

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
target_width=22
target_height=22

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/22x22/apps/"

# Find image by dimension
image_file10=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file10" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file10" "$dest_dir"
echo $image_file10
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file11##*.}"
  mv "$dest_dir/$(basename "$image_file11")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file11")"
fi
search_dir="$HOME/zen/"

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
target_width=256
target_height=256

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/256x256/apps/"

# Find image by dimension
image_file12=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file12" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file12" "$dest_dir"
echo $image_file12
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file12##*.}"
  mv "$dest_dir/$(basename "$image_file12")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
else
  exported_filename="$(basename "$image_file12")"
fi
done
# Directory to search for image files
# Target dimensions
target_width=42
target_height=42

# Destination directory
dest_dir="~/$DEB_DIR/usr/share/icons/hicolor/42x42/apps/"

# Find image by dimension
image_file13=$(find "$search_dir" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -exec identify -format "%wx%h %i\n" {} + | awk -v target_width="$target_width" -v target_height="$target_height" '$1 == target_width"x"target_height {print $2; exit}')

# Check if image file is found
if [ -z "$image_file13" ]; then
  echo "No image file found with dimensions ${target_width}x${target_height}."
  exit 1
fi
# Move the file to the destination directory
cp -r "$image_file13" "$dest_dir"
echo $image_file13
# Prompt the user for renaming the file
#!/bin/bash
echo "Do you want to rename the file (excluding the file extension)? (yes/no)"
read answer

if [ "$answer" == "yes" ]; then
  echo "Enter the new filename (without extension):"
  read new_filename
  extension="${image_file13##*.}"
  mv "$dest_dir/$(basename "$image_file13")" "$dest_dir/$new_filename.$extension"
  exported_filename="$new_filename.$extension"
elif [ "$answer" == "no" ]; then
echo "not changing filename"
break
else
  exported_filename="$(basename "$image_file13")"
fi


busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/$TAR_EXEC ~/$DEB_DIR/usr/bin 
busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/$TAR_EXEC2 ~/$DEB_DIR/usr/bin
dpkg-deb --build ~/$DEB_DIR