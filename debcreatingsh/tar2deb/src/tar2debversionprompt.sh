#!/bin/bash
BBlack=$(tput setaf 0; tput bold)
NoColor=$(tput sgr0)
# Function to check if input is a number
is_number() {
    [[ "$1" =~ ^[0-9+\.]+$ ]];
}

# Prompt user for input
while true; do
    read -p "Please enter a Version for your package: " Version
    if is_number "$Version"; then
        clear
        echo "The version of your package is: ${BBlack}$Version${NoColor}"
        read -p "do you want to change the version of your package? (yes/no) " yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debversionprompt.sh
    elif [ "$yesorno" = no ]; then
    echo "not changing package version"
    break
    else
    echo "Not a number."
    exit 1
    fi
        break
    else
        echo "Invalid input. Please enter a valid number."
    fi
done
