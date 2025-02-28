#!/bin/bash


# Define the directory to search for files and the directory where the .desktop file should be created
TARGET_DIR="$HOME/zen"
DESKTOP_DIR=$HOME"

# Function to find the graphical executable
find_graphical_executable() {
    for file in "$TARGET_DIR"/*; do
        if [[ -x "$file" && $(file "$file" | grep -i 'executable') ]]; then
            # Return the first executable found (could be enhanced for finding the most common type of executable)
            echo "$file"
            return
        fi
    done
    echo ""
}

# Check if a .desktop file exists in the specified directory
if [[ ! -f "$DESKTOP_DIR/$(basename "$TARGET_DIR").desktop" ]]; then
    graphical_exec=$(find_graphical_executable)

    if [[ -z "$graphical_exec" ]]; then
        echo "No graphical executable found in the directory."
        exit 1
    fi

    # Ask user if they want to create a .desktop file
    while true; do
        read -p "Do you want to create a .desktop file for $graphical_exec? (yes/no): " create_choice
        if [[ "$create_choice" == "yes" || "$create_choice" == "y" ]]; then
            read -p "Enter the filename for the .desktop file: " filename
            desktop_file="$DESKTOP_DIR/$filename.desktop"
            echo "Creating $desktop_file..."

            # Create the .desktop file
            echo "[Desktop Entry]" > "$desktop_file"
            echo "Version=1.0" >> "$desktop_file"
            echo "Name=$(basename "$graphical_exec")" >> "$desktop_file"
            echo "Comment=Generated .desktop file" >> "$desktop_file"
            echo "Exec=$graphical_exec" >> "$desktop_file"
            echo "Icon=" >> "$desktop_file"  # Optionally add an icon
            echo "Terminal=false" >> "$desktop_file"
            echo "Type=Application" >> "$desktop_file"
            chmod +x "$desktop_file"
            echo ".desktop file created successfully!"
            break
        elif [[ "$create_choice" == "no" || "$create_choice" == "n" ]]; then
            echo "Skipping creation of .desktop file."
            break
        else
            echo "Invalid input. Please answer 'yes' or 'no'."
        fi
    done
else
    echo ".desktop file already exists in $DESKTOP_DIR"
fi

# Continue with other parts of the script if needed
