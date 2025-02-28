#!/bin/bash

# Define colors
NoColor=$(tput sgr0)
BWhite=$(tput setaf 7; tput bold)

# Sample deb file for demonstration
debfile="$HOME/$DEB_DIR.deb"  # Replace with actual variable if needed

# Function to check if the input contains a dot (.)
validate_filename() {
    if [[ "$1" == *"."* ]]; then
        echo "Error: Filenames cannot contain the '.' character."
        return 1
    else
        return 0
    fi
}

# Loop for user confirmation and renaming
while true; do
    read -p "Do you want to rename this ${BWhite}$debfile${NoColor} file? (yes/no): " yesorno

    if [[ "$yesorno" == "yes" ]]; then
        while true; do
            # Ask for the new filename (without extension)
            read -p "What do you want the filename to be? " filerename

            # Validate the filename (no dots allowed)
            validate_filename "$filerename"
            if [[ $? -eq 0 ]]; then
                # Ensure no extension is included
                new_filename="${filerename%.deb}"  # Remove any .deb if accidentally added
                mv "$debfile" "$HOME/$new_filename.deb"
                echo "File renamed to $new_filename.deb"
                break
            fi
        done
        break

    elif [[ "$yesorno" == "no" ]]; then
        read -p "Are you sure you don't want to change the filename of your choice? (yes/no): " yesorno2
        
        if [[ "$yesorno2" == "no" ]]; then
            while true; do
                # Ask for the new filename (without extension)
                read -p "What do you want the filename to be? " filerename2

                # Validate the filename (no dots allowed)
                validate_filename "$filerename2"
                if [[ $? -eq 0 ]]; then
                    # Ensure no extension is included
                    new_filename2="${filerename2%.deb}"  # Remove any .deb if accidentally added
                    mv "$debfile" "$HOME/$new_filename2.deb"
                    echo "File renamed to $new_filename2.deb"
                    break
                fi
            done
            break
        elif [[ "$yesorno2" == "yes" ]]; then
            echo "Not changing filename."
            break
        fi
    fi
done
