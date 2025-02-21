#!/bin/bash

# Function to check if input is a number
is_letter() {
    [[ "$1" =~ ^[Aa-zZ]+$ ]];
}

# Prompt user for input
while true; do
    read -p "Please enter the name of the maintainer of the package: " Maintainer
    if is_letter "$Maintainer"; then
        clear
        echo "The name of the maintainer of your package is: $Maintainer"
        read -p "do you want to change the name of the maintainer of your package? (yes/no)" yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debversionprompt.sh
    elif [ "$yesorno" = no ]; then
    clear
    echo "not changing package maintainer"
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