#!/bin/bash

# Define the main directory to search in
SEARCH_DIR="$HOME/blender-4.3.2-linux-x64/"

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
echo "Subdirectory with the most binary files: $MOST_BINARIES_SUBDIR"
