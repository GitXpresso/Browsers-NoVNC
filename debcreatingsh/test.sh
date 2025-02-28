#!/bin/bash

# Define the directory to search
specified_directory="$HOME/$TAR_DIR"

# Check for a .desktop file in the specified directory
desktop_file=$(find "$specified_directory" -maxdepth 1 -type f -iname "*.desktop")

if [[ -n "$desktop_file" ]]; then
  echo "Found a .desktop file: $desktop_file"
else
  # No .desktop file found, ask user if they want to create one
  read -p "No desktop file found in '$specified_directory'. Do you want to create one? (yes/no): " user_input

  if [[ "$user_input" == "yes" ]]; then
    # Find graphical executables excluding binary files
    executable_file=$(find "$specified_directory" -type f ! -exec file {} + | grep -i 'executable' | grep -vi 'binary' | head -n 1)

    if [[ -n "$executable_file" ]]; then
      # Create a .desktop file with the found executable
      desktop_filename="$specified_directory/$(basename "$executable_file").desktop"
      echo "Creating .desktop file for $executable_file..."

      cat > "$desktop_filename" <<EOL
[Desktop Entry]
Version=1.0
Name=Custom Application
Exec=$executable_file
Icon=application-icon
Terminal=false
Type=Application
Categories=Utility;
EOL

      echo ".desktop file created at $desktop_filename"
    else
      echo "No graphical executable found. Aborting desktop creation."
    fi
  else
    echo "Not creating desktop file."
  fi
fi

# Continue with the rest of the script
echo "Continuing with the script..."
