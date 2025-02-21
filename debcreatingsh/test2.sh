# Function to check if input is a number
is_letter() {
    [[ "$1" =~ ^[Aa-Zz]+$ ]];
}
# Prompt user for input
while true; do
    read -p "Please enter your name or some elses name as the maintainer for the package: " Maintainer
    if is_letter "$Maintainer"; then
        clear
        echo "The Maintainer of your package is: $Maintainer"
        read -p "do you want to change the version of your package? (yes/no)" yesorno
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
