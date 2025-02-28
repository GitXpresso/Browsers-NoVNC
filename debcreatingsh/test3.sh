#!/bin/bash

# Directory to search
source_directory="/path/to/source/directory"

# Directory to move files to
destination_directory="/workspace/Browsers-NoVNC/debcreatingsh/test"

# Create the destination directory if it doesn't exist
mkdir -p "$destination_directory"

# Find executable files (excluding binary files) and move them
find "$source_directory" -type f -executable | while read -r file; do
    if file "$file" | grep -qE 'script|text'; then
        mv "$file" "$destination_directory/"
    fi
done

# Display a message indicating the operation is complete
echo "Executable files (excluding binary files) have been moved to: $destination_directory"
