#!/bin/bash

# Configuration: Change these variables to suit your setup
REPO_NAME="tar2deb"
REPO_DIR="$HOME/$REPO_NAME"
ARCHITECTURE="amd64"          # You can change this if using a different architecture like armhf or i386
DEB_FILE="$1"                 # The first argument passed to the script will be the .deb file
RELEASE_NAME="jammy"          # Set the release name (e.g., "focal", "bionic")
DEB_SIGN_KEY="43391CEB6BF03EB6"  # Your GPG key ID for signing (use the output of `gpg --list-secret-keys`)

# Check if a .deb file was provided as an argument
if [ -z "$DEB_FILE" ]; then
    echo "Usage: $0 <path-to-deb-file>"
    exit 1
fi

# Check if the .deb file exists
if [ ! -f "$DEB_FILE" ]; then
    echo "Error: .deb file not found: $DEB_FILE"
    exit 1
fi

# Function to initialize the PPA repository structure
initialize_repo() {
    echo "Initializing repository structure..."
    
    mkdir -p "$REPO_DIR/pool/main"
    mkdir -p "$REPO_DIR/dists/$RELEASE_NAME/main/binary-$ARCHITECTURE"
    
    echo "Repository structure created."
}

# Function to add the .deb package to the repository
add_package_to_repo() {
    echo "Adding .deb package to the repository..."
    
    # Copy the .deb package to the pool/main directory
    cp "$DEB_FILE" "$REPO_DIR/pool/main/"
    
    # Generate the Packages.gz file
    dpkg-scanpackages "$REPO_DIR/pool" /dev/null | gzip -9c > "$REPO_DIR/dists/$RELEASE_NAME/main/binary-$ARCHITECTURE/Packages.gz"
    
    echo "Package added to repository."
}

# Function to generate the Release file for the repository
generate_release_file() {
    echo "Generating Release file..."
    
    cat > "$REPO_DIR/dists/$RELEASE_NAME/Release" <<EOF
Origin: tar2deb
Label: first tar2deb ppa repository
Suite: $RELEASE_NAME
Codename: $RELEASE_NAME
Architectures: $ARCHITECTURE
Components: main
Description: Convert almost any extracted tar file into a .deb file
SignWith: $DEB_SIGN_KEY
EOF
    
    echo "Release file generated."
}

# Function to sign the repository (Release and Packages.gz)
sign_repository() {
    echo "Signing repository files with GPG..."
    
    # Sign the Release file
    gpg --armor --detach-sign --sign-with "$DEB_SIGN_KEY" "$REPO_DIR/dists/$RELEASE_NAME/Release"
    
    # Sign the Packages.gz file
    gpg --armor --detach-sign --sign-with "$DEB_SIGN_KEY" "$REPO_DIR/dists/$RELEASE_NAME/main/binary-$ARCHITECTURE/Packages.gz"
    
    echo "Repository signed."
}

# Main script execution
echo "Starting PPA repository creation..."

initialize_repo
add_package_to_repo
generate_release_file
sign_repository

echo "PPA repository created successfully."
