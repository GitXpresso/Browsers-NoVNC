#!/bin/bash

# Directory to search for the .desktop file
# Name of the .desktop file to check
desktop_file_name="*.desktop"
# Path to the .desktop file
desktop_file_path="$search_dir/$desktop_file_name"

# Check if the .desktop file exists
if [[ ! -f "$desktop_file_path" ]]; then
  # Prompt the user if they want to create the .desktop file
  read -p "The .desktop file is not found. Do you want to create it? (yes/no): " answer
  
  if [[ "$answer" == "yes" ]]; then
    # Directory containing the executable file
    exec_dir="/path/to/executable/directory"
    # Find the executable file in the directory
    executable=$(find "$exec_dir" -maxdepth 1 -type f -executable -print -quit)

    if [[ -n "$executable" ]]; then
      # Check if the executable is a graphical application
      if file "$executable" | grep -q "ELF.*executable"; then
        # Create the graphical .desktop file
        cat > "$desktop_file_path" << EOL
[Desktop Entry]
Name=My Application
Exec=$executable
Icon=/path/to/icon.png
Terminal=false
Type=Application
EOL
        echo "Graphical .desktop file created at $desktop_file_path"
      else
        # Create a non-graphical .desktop file
        cat > "$desktop_file_path" << EOL
[Desktop Entry]
Name=My Application
Exec=$executable
Terminal=true
Type=Application
EOL
        echo "Non-graphical .desktop file created at $desktop_file_path"
      fi
    else
      echo "No executable file found in $exec_dir"
    fi
  else
    echo ".desktop file creation skipped."
  fi
else
  echo ".desktop file already exists at $desktop_file_path"
fi
