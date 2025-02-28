ls48x48() {
# Directory to check
directory="$HOME/usr/share/icons/hicolor/48x48/apps"


# Count the number of files in the directory
file_count=$(ls -1 "$directory" | wc -l)

# Get the filenames and export as a variable
file_list=$(ls -1 "$directory")

# Create a numeric list file with filenames next to it
numeric_list_file="$directory/numeric_list.txt"
cat <<EOL > "$numeric_list_file"
$(ls -1 /usr/share/icons/hicolor | nl)
EOL
numberic48x48=$(cat -v $numeric_list_file)
# Display the numeric list file path
echo "$numberic48x48"
}
ls48x48exclude() {

# Directory to check
directory="$HOME/usr/share/icons/hicolor/"

# Directories to exclude
exclude_dirs=("symbolic" "scalable" "index.theme")

# Generate exclusion pattern
exclude_pattern=$(printf "|%s" "${exclude_dirs[@]}")
exclude_pattern=${exclude_pattern:1}

# Create a numeric list file with filenames next to it using `cat` here document
numeric_list_file="$HOME/usr/share/Tar2DebLists/hicolor.txt"
cat <<EOL > "$numeric_list_file"
Number of files: $(ls -1 "$directory" | grep -Ev "($exclude_pattern)" | wc -l)
File List:
$(ls -1 "$directory" | grep -Ev "($exclude_pattern)" | nl)
EOL

# Display the numeric list file path
cat -v $numeric_list_file
}
ls48x48

read -p "do you want to pick a file from a directory in the numberic list to rename: (yes/no) " yesorno48x48
ls48x48exclude
if [[ $yesorno48x48 = " 48x48 "]]
echo "you picked 48x48
elif
