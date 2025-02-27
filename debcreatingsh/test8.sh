#!/bin/bash

# Directory to search for .desktop files
SEARCH_DIR="$1"
# Directory to save new .desktop files
SAVE_DIR="$2"

# Find a .desktop file in the specified directory
desktop_file=$(find "$SEARCH_DIR" -maxdepth 1 -name "*.desktop" -print -quit)

if [ -z "$desktop_file" ]; then
  echo "No .desktop file found in $SEARCH_DIR."
  read -p "Do you want to create a .desktop file? (yes/no): " create_choice

  if [ "$create_choice" == "yes" ]; then
    # Find graphical executable files excluding binary files
    executables=$(find "$SEARCH_DIR" -maxdepth 1 -type f -executable ! -name "*.bin")
    if [ -z "$executables" ]; then
      echo "No graphical executable files found in $SEARCH_DIR."
      read -p "Do you want to create a non-graphical .desktop file? (yes/no): " create_non_graphical

      if [ "$create_non_graphical" == "yes" ]; then
        # Find non-graphical executable files excluding binary files
        non_graphical_executables=$(find "$SEARCH_DIR" -maxdepth 1 -type f -executable ! -name "*.bin")
        largest_executable=$(echo "$non_graphical_executables" | xargs ls -S | head -n 1)

        if [ -n "$largest_executable" ]; then
          export EXECUTABLE_PATH="$largest_executable"
          cat > "$SAVE_DIR/new_non_graphical.desktop" << EOF
[Desktop Entry]
Name=Non-Graphical Application
Exec=$EXECUTABLE_PATH
Type=Application
Terminal=true
EOF
          echo ".desktop file created for non-graphical executable: $EXECUTABLE_PATH"
        else
          echo "No non-graphical executable files found."
        fi
      else
        echo "Aborting script."
        exit 0
      fi
    else
      # Find the largest graphical executable file
      largest_executable=$(echo "$executables" | xargs ls -S | head -n 1)

      if [ -n "$largest_executable" ]; then
        export EXECUTABLE_PATH="$largest_executable"
        cat > "$SAVE_DIR/new_graphical.desktop" << EOF
[Desktop Entry]
Name=Graphical Application
Exec=$EXECUTABLE_PATH
Type=Application
Terminal=false
EOF
        echo ".desktop file created for graphical executable: $EXECUTABLE_PATH"
      else
        echo "No graphical executable files found."
      fi
    fi
  else
    echo "Aborting script."
    exit 0
  fi
else
  echo ".desktop file found: $desktop_file"
fi
