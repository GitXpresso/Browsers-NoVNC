#!/bin/bash

# List of packages you want to check
PACKAGES=("wget" "tar" "imagemagick" "devscripts" "build-essential" "debhelper" "libasound-dev" "busybox")

# Loop through each package
for PACKAGE in "${PACKAGES[@]}"; do
    # Check if the package is installed
    if dpkg-query -W -f='${Status}' "$PACKAGE" 2>/dev/null | grep -q "install ok installed"; then
        # Get the installed size of the package
        SIZE=$(dpkg-query -W -f='${Installed-Size}' "$PACKAGE")
        # Convert size from 1K blocks to MB
        SIZE_MB=$((SIZE / 1024))
        echo "$PACKAGE is installed. Size: ${SIZE_MB}MB"
    else
        echo "$PACKAGE is not installed."
    fi
done
