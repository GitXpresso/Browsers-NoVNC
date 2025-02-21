#!/bin/bash

# Function to check if input is a number
is_number() {
    [[ $1 =~ ^[0-9]+$ ]]
}

# Prompt user for input
while true; do
    read -p "Please enter a number: " user_input
    if is_number "$user_input"; then
        echo "Thank you! You entered the number: $user_input"
        break
    else
        echo "Invalid input. Please enter a valid number."
    fi
done