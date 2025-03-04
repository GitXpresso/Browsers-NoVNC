#!/bin/bash
BBlack=$(tput setaf 0; tput bold)
NoColor=$(tput sgr0)

# Function to validate and create full name
create_full_name() {
  local input=("$@")
  local first_name=""
  local last_name=""
  local valid_input=true

  # Validate and separate first and last name
  for word in "${input[@]}"; do
    if [[ ! "$word" =~ [0-9] ]]; then
      if [ -z "$first_name" ]; then
        first_name="$word"
      elif [ -z "$last_name" ]; then
        last_name="$word"
      fi
    else
      valid_input=false
      break
    fi
  done

  if [ "$valid_input" = true ] && [ -n "$first_name" ] && [ -n "$last_name" ]; then
    full_name="$first_name $last_name"
    echo "Valid full name: $full_name"
    export Maintainer="$full_name"
  else
    echo "Invalid input. Please enter only letters and spaces for the first and last name."
  fi
}

# Prompt user for input
while true; do
    read -p "Please enter your name or some elses name as the maintainer for the package: " -a Maintainer
    if IFS=" " create_full_name "${Maintainer[@]}"; then
        clear
        echo "The Maintainer of your package is: ${BBlack}$Maintainer${NoColor}"
        read -p "do you want to change the maintainer name of your package? (yes/no) " yesorno
    if [ "$yesorno" = yes ]; then
    clear
    bash ./tar2debmaintainerprompt.sh
    elif [ "$yesorno" = no ]; then
    clear
    echo "not changing package maintainer name"
    break
    else
    echo "Not a letter."
    exit 1
    fi
        break
    else
        echo "Invalid input. Please enter a valid letter."
    fi
done
