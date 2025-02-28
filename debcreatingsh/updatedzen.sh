#!/bin/bash

# Directory to check
DEB_DIR="zen2deb-1.0.0"

directory="$HOME/$DEB_DIR/usr/share/icons/hicolor/48x48/apps"
directory2="$HOME/$DEB_DIR/usr/lib/tar2debNumbericList"

mkdir -p "$directory" 
mkdir -p "$directory2" 

# Count the number of files in the directory
file_count=$(ls -1 "$directory" | wc -l)
echo "Number of files in the directory: $file_count"

# Get the filenames and export as a variable
file_list=$(ls -1 "$directory")
echo "Files in the directory: $file_list"

# Create empty variables for each file
declare -a file_vars
for ((i=1; i<=file_count; i++)); do
    file_vars[$i]=""
done

# Use IFS to separate into the empty variables one by one
IFS=$'\n' read -r -d '' -a file_array <<< "$file_list"
for ((i=0; i<file_count; i++)); do
    file_vars[$i+1]="${file_array[$i]}"
done

# Display the variables
for ((i=1; i<=file_count; i++)); do
    echo "file_vars[$i]: ${file_vars[$i]}"
done

# Export the number of files counted into a numeric list file
numeric_list=()
for ((i=1; i<=file_count; i++)); do
    numeric_list+=($i)
done

# Write the numeric list to a file
numeric_list_file="$directory2/numeric_list48x48.txt"
printf "%s\n" "${numeric_list[@]}" > "$numeric_list_file"

# Display the numeric list file path
echo "Numeric list file created at: $numeric_list_file"


