#!/bin/bash
DEB_DIR="palemoon-33.5.1"
declare -A dest_dirs=(
  ["8x8"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/8x8/apps"
  ["16x16"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/16x16/apps"
  ["22x22"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/22x22/apps"
  ["24x24"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/24x24/apps"
  ["32x32"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/32x32/apps"
  ["36x36"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/36x36/apps"
  ["42x42"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/42x42/apps"
  ["48x48"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/48x48/apps"
  ["64x64"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/64x64/apps"
  ["72x72"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/72x72/apps"
  ["96x96"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/96x96/apps"
  ["128x128"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/128x128/apps"
  ["192x192"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/192x192/apps"
  ["256x256"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/256x256/apps"
  ["512x512"]="$HOME/$DEB_DIR/usr/share/icons/hicolor/512x512/apps"
  ["unlisted"]="$HOME/$DEB_DIR/usr/share/unlisted_dimensions"
)

# Create the destination directories if they don't exist
# Set the target directory (Change this to your target directory)
target_dir="$HOME/palemoon"
target_dir3="$HOME/palemoon-33.5.1/usr/share/applications"
# Find the most linked graphical executable
find_main_executable() {
    find "$target_dir" -type f -executable ! -name "*.sh" ! -name "*.so" |grep -v -E 'glxtest|updater|vaapitest|pingsender|plugin-container|run-mozilla.sh|*-bin' | while read -r file; do
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
            file_paths=()
            counter=1
            # Find image files
            for img in "${dest_dirs[@]}"; do
            for file in "img"/*; do
            if [[ -f "$file" ]]; then
            file_paths+=("$file")  # Store full path
            image_lists+=("$(basename "$file")")
            echo "$counter. $(basename "$img")"
                    ((counter++))
            fi
          done
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
        desktop_file_path="$target_dir3/$(basename "$MAIN_EXEC" .sh).desktop"
        echo "[Desktop Entry]" > "$desktop_file_path"
        echo "Name=$(basename "$MAIN_EXEC")" >> "$desktop_file_path"
        echo "Version=$Version" >> "$desktop_file_path"
        echo "StartupWMClass=$MAIN_EXEC" >> "$desktop_file_path"
        echo "Type=Application" >> "$desktop_file_path"
        echo "Exec=$MAIN_EXEC" >> "$desktop_file_path"
        [[ -n "$icon_path" ]] && echo "Icon=$icon_path" >> "$desktop_file_path"
        echo "Terminal=false" >> "$desktop_file_path"
        chmod +x "$desktop_file_path"
        echo "Desktop file created at: $desktop_file_path"
    fi
fi

echo "Continuing with the rest of the script..."
