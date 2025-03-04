#!/bin/bash

# Set default values for repository parameters
REPO_NAME="tar2deb"
REPO_DIR="$HOME/$REPO_NAME"
ARCHITECTURE="amd64"
PACKAGE_DIR="$REPO_DIR/pool/main"
DEB_SIGN_KEY="9CEC800E4B8F8994"
RELEASE_NAME="jammy"  # Change to your Ubuntu version, e.g., "bionic", "focal"

# Function to initialize the repository
initialize_repo() {
  echo "Initializing PPA repository structure..."
  
  # Create directory structure
  mkdir -p "$PACKAGE_DIR"
  mkdir -p "$REPO_DIR/dists/$RELEASE_NAME/main/binary-$ARCHITECTURE"
  
  echo "Repository structure created."
}

# Function to add package to the repository
add_package() {
  PACKAGE_PATH="$1"
  
  if [ ! -f "$PACKAGE_PATH" ]; then
    echo "Package file not found: $PACKAGE_PATH"
    exit 1
  fi
  
  echo "Adding package: $PACKAGE_PATH to repository..."
  
  # Copy package to the pool directory
  cp "$PACKAGE_PATH" "$PACKAGE_DIR/"
  
  # Generate Packages file
  dpkg-scanpackages "$REPO_DIR/pool" /dev/null | gzip -9c > "$REPO_DIR/dists/$RELEASE_NAME/main/binary-$ARCHITECTURE/Packages.gz"
  
  echo "Package added to repository."
}

# Function to generate the Release file
generate_release() {
  echo "Generating Release file..."
  
  # Create Release file
  cat > "$REPO_DIR/dists/$RELEASE_NAME/Release" <<EOF
Origin: My PPA
Label: My PPA Repository
Suite: $RELEASE_NAME
Codename: $RELEASE_NAME
Architectures: $ARCHITECTURE
Components: main
Description: Custom PPA repository for packages
SignWith: $DEB_SIGN_KEY
EOF
  
  echo "Release file generated."
}

# Function to sign the repository with GPG key
sign_repository() {
  echo "Signing the repository..."
  
  # Sign the Release file and Packages.gz
  gpg --armor --detach-sign --sign-with "$DEB_SIGN_KEY" "$REPO_DIR/dists/$RELEASE_NAME/Release"
  gpg --armor --detach-sign --sign-with "$DEB_SIGN_KEY" "$REPO_DIR/dists/$RELEASE_NAME/main/binary-$ARCHITECTURE/Packages.gz"
  
  echo "Repository signed."
}

# Main script execution
echo "Starting PPA repository creation..."

initialize_repo

# Add the package(s) you want to the repository
# You can add more packages if needed
add_package "$1"

# Generate the Release and sign the repository
generate_release
sign_repository

echo "PPA repository created successfully."

