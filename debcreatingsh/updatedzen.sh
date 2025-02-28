#!/bin/bash

# Directory to check
directory="$HOME/usr/share/icons/hicolor/48x48/apps"


# Count the number of files in the directory
file_count=$(ls -1 "$directory" | wc -l)
echo "Number of files in the directory: $file_count"

# Get the filenames and export as a variable
file_list=$(ls -1 "$directory")
echo "Files in the directory: $file_list"

# Create a numeric list file with filenames next to it
numeric_list_file="$directory/numeric_list.txt"
cat <<EOL > "$numeric_list_file"
$(ls -1 "$directory" | nl)
EOL
numberic48x48=$(cat -v $numeric_list_file)
# Display the numeric list file path
echo "$numberic48x48"
