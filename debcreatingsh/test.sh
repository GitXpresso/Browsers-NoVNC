#!/bin/bash

# Directory to search for executable files
DIRECTORY="$HOME/zen"

# Find the first two executable files in the directory
EXECUTABLES=($(find "$DIRECTORY" -type f -executable | head -n 2))

# Function to check if an executable is a graphical executable
is_graphical_executable() {
    file "$1" | grep -qE 'ELF.*(executable|shared object)'; return $?
}

# Variable to store the graphical executable
GRAPHICAL_EXECUTABLE=""

# Loop through the found executables and check if they are graphical
for executable in "${EXECUTABLES[@]}"; do
    if is_graphical_executable "$executable"; then
        GRAPHICAL_EXECUTABLE="$executable"
        break
    fi
done

# Export the graphical executable as a variable if found
if [ -n "$GRAPHICAL_EXECUTABLE" ]; then
    export GRAPHICAL_EXECUTABLE
    echo "Graphical executable to run: $GRAPHICAL_EXECUTABLE"
else
    echo "No graphical executable files found in the directory."
fi
