#!/bin/bash

# Function to check if input is a number
is_number() {
    [[ $1 =~ ^[0-9]+$ ]]
}

# Prompt user for input
while true; do
    read -p "Please enter a Version for your package: " Version
    if is_number "$Version"; then
        clear
        echo "The version of your package is: $user_input"
        break
    else
        echo "Invalid input. Please enter a valid number."
    fi
done