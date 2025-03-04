#!/bin/bash
BBlack=$(tput setaf 0; tput bold)
NoColor=$(tput sgr0)
# Function to check if input is a number
is_letter() {
    [[ "$1" =~ ^[Aa-zZ]+$ ]];
}

# Prompt user for input
while true; do
    read -p "Please enter the name of your package: " PackageName
    if is_letter "$PackageName"; then
        clear
        echo "The name of your package is: ${BBlack}$PackageName${NoColor}"
        read -p "do you want to change the name of your package? (yes/no) " yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debpackagenameprompt.sh
    elif [ "$yesorno" = no ]; then
    clear
    echo "not changing name of package"
    clear
    break
    else
    echo "Not a name."
    exit 1
    fi
        break
    else
        echo "Invalid input. Please enter a valid letter."
    fi
done
