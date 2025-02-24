#!/bin/bash
# Install Zen Browser to create .deb package
sudo apt-get install tar wget build-essential devscripts debhelper busybox -y
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
tarfile=$(wget -P ~/ -nv $TAR_URL 2>&1 | cut -d\" -f2) && TAR_DIR=$(tar -xvf $tarfile -C ~/ | cut -d / -f1 | uniq) && sudo rm -f $tarfile

# Function to check if input is a number
is_letter() {
    [[ "$1" =~ ^[Aa-zZ]+$ ]];
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
    exit 1
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
    exit 1
    fi
        break
    else
        echo "Invalid input. Please enter a valid number."
    fi
done
export $PackageName
export $Version
DEB_DIR="$PackageName-$Version"
export $DEB_DIR
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
    exit 1
    fi
        break
    else
        echo "Invalid input. Please enter a valid letter."
    fi
done
clear
read -p "what is your package about?; or just type anything: " Description
cat << EOF >~/$DEB_DIR/DEBIAN/control
Package: $Package
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
mkdir -p ~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/
echo -e "copying executable files to $DEB_DIR"
echo "copying image files to $DEB_DIR"
cp -r ~/$TAR_DIR/* ~/$DEB_DIR/usr/lib/$TAR_DIR/
cp -r ~/$TAR_DIR/lib*.so ~/$DEB_DIR/usr/lib/
cp -r ~/$TAR_DIR/browser/chrome/icons/default/default48.png ~/$DEB_DIR/usr/share/icons/hicolor/48x48/apps/${NAME_OF_IMAGE}.png
busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/${TAR_EXEC} ~/$DEB_DIR/usr/bin 
busybox ln -s ~/$DEB_DIR/usr/lib/$TAR_DIR/${TAR_EXEC2} ~/$DEB_DIR/usr/bin
dpkg-deb --build ~/$DEB_DIR
