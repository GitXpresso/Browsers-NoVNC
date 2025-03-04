#!/bin/bash

# This script is designed to help you create a PPA and build a simple Debian package
# for uploading it to the PPA repository on Launchpad. It is not fully automatic and
# requires user input for several key steps.

# Ensure the necessary tools are installed
echo "Installing required dependencies..."
sudo apt update
sudo apt install -y build-essential debhelper dpkg-dev fakeroot dh-make dput wget

# Create your project directory
echo -n "Enter your project name (e.g., hello-world): "
read PROJECT_NAME
mkdir "$PROJECT_NAME"
mkdir -p $PROJECT_NAME/debian
cd "$PROJECT_NAME" || exit

# Create a basic C program (or any simple project you wish to package)
echo "Creating a simple hello-world C program..."
mkdir src
cp /workspace/Browsers-NoVNC/debcreatingsh/tar2deb.sh src/tar2deb
cp /workspace/Browsers-NoVNC/debcreatingsh/tar2debmaintainerprompt.sh src
cp /workspace/Browsers-NoVNC/debcreatingsh/tar2debpackagenameprompt.sh src
cp /workspace/Browsers-NoVNC/debcreatingsh/tar2debversionprompt.sh src
# Initialize the Debian package structure using dh_make
echo "Running dh_make to initialize the Debian package structure..."
dh_make --createorig

# Now we need to customize the files manually (debian/control, debian/changelog, etc.)
echo "You need to edit the following files to provide more details:"
echo "1. debian/control"
echo "2. debian/changelog"
echo "3. debian/rules (if you want to customize it, but you can leave it empty)"
echo "Press Enter to continue after editing these files."
read -p "Press Enter to continue..."

# The user should manually edit the control and changelog files
# Here's a quick suggestion of what should be in the files:


cat << EOF > /workspace/Browsers-NoVNC/debcreatingsh/$PROJECT_NAME/debian/control

Source: tar2deb
Section: utils
Priority: optional
Maintainer: William Gwin <wg9797@outlook.com>
Build-Depends: debhelper (>= 12), gcc
Standards-Version: 4.5.2

Package: tar2deb
Architecture: any
Depends: \${shlibs:Depends}, \${misc:Depends}
Description: Convert almost any extracted tar file into a .deb file
  first release of tar2deb
EOF

cat << EOF > /workspace/Browsers-NoVNC/debcreatingsh/$PROJECT_NAME/debian/changelog
tar2deb (1.0.0) unstable; urgency=low

  * first every release

 -- William Gwin <wg9797@outlook.com>  $(date "+%a, %d %b %Y %T %z")
EOF
echo "Now that you have made the edits, you can continue."

# Prompt for the Launchpad PPA details
echo -n "Enter your Launchpad username: "
read LAUNCHPAD_USER
echo -n "Enter the PPA name (e.g., myusername/hello-world): "
read PPA_NAME

# Build the package
echo "Building the Debian package using debuild..."
debuild -us -uc

# Install dput if not installed
sudo apt install -y dput

# Prepare the .dput.cf file to upload to Launchpad
echo "Setting up dput configuration..."
cat <<EOF > ~/.dput.cf
[launchpad]
fqdn = ppa.launchpad.net
method = ftp
incoming = /upload
login = $LAUNCHPAD_USER
passphrase = 
EOF
cat <<EOF > ~/.dput.cf
method = sftp
login = ~gitxpresso
EOF
# Upload the package to Launchpad PPA
echo "Uploading the package to Launchpad..."
dput ppa:/"${PROJECT_NAME}"_1.0-1_amd64.changes

# Output installation instructions
echo "To install your package from the PPA, run the following commands on a target machine:"
echo "1. Add your PPA repository:"
echo "   sudo add-apt-repository ppa:$PPA_NAME"
echo "2. Update package lists:"
echo "   sudo apt update"
echo "3. Install your package:"
echo "   sudo apt install hello-world"