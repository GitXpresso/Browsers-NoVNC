#!/bin/bash

# Set the target directory (Change this to your target directory)
target_dir="$HOME/specific_directory"

# Find the most linked graphical executable
find_main_executable() {
    find "$target_dir" -type f -executable ! -name "*.sh" ! -name "*.so" | while read -r file; do
        links=$(ldd "$file" 2>/dev/null | wc -l)
        echo "$links $file"
    done | sort -nr | awk 'NR==1{print $2}'
}

main_executable=$(find_main_executable)

# Check if an executable was found
if [[ -z "$main_executable" ]]; then
    echo "No graphical executable found."
    exit 1
fi

export MAIN_EXEC="$main_executable"
echo "Main executable found: $MAIN_EXEC"

# Check if a desktop file exists
desktop_file=$(find "$target_dir" -type f -name "*.desktop")

if [[ -z "$desktop_file" ]]; then
    read -p "No .desktop file found. Do you want to create one? (yes/no): " create_desktop
    if [[ "$create_desktop" == "yes" ]]; then
        # Ask if the user wants to choose an icon
        read -p "Do you want to pick an icon for the desktop file? (yes/no): " pick_icon
        icon_path=""

        if [[ "$pick_icon" == "yes" ]]; then
            echo "Creating a list of available images:"
            images_list=()
            counter=1

            # Find image files
            for img in "$target_dir"/*.{png,jpg,jpeg,svg}; do
                if [[ -f "$img" ]]; then
                    images_list+=("$img")
                    echo "$counter. $(basename "$img")"
                    ((counter++))
                fi
            done

            # Ask user to select an image
            if [[ ${#images_list[@]} -gt 0 ]]; then
                while true; do
                    read -p "Enter the number of the image you want to use as an icon (or 'q' to skip): " selected_number
                    if [[ "$selected_number" == "q" ]]; then
                        break
                    elif [[ "$selected_number" -ge 1 && "$selected_number" -le ${#images_list[@]} ]]; then
                        icon_path="${images_list[$selected_number-1]}"
                        echo "Icon selected: $icon_path"
                        break
                    else
                        echo "Invalid selection. Try again."
                    fi
                done
            else
                echo "No image files found."
            fi
        fi

        # Create .desktop file
        desktop_file_path="$target_dir/$(basename "$MAIN_EXEC" .sh).desktop"
        echo "[Desktop Entry]" > "$desktop_file_path"
        echo "Type=Application" >> "$desktop_file_path"
        echo "Name=$(basename "$MAIN_EXEC")" >> "$desktop_file_path"
        echo "Exec=$MAIN_EXEC" >> "$desktop_file_path"
        [[ -n "$icon_path" ]] && echo "Icon=$icon_path" >> "$desktop_file_path"
        echo "Terminal=false" >> "$desktop_file_path"
        echo "Categories=Utility;" >> "$desktop_file_path"

        chmod +x "$desktop_file_path"
        echo "Desktop file created at: $desktop_file_path"
    fi
fi

echo "Continuing with the rest of the script..."
