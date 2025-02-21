while true; do
    read -p "enter the version of your package: " Version
    if [[ $Version =~ ^[0-9]+$ ]]; then
        clear
        echo "The version of your package you've entered: $Version"
        break
        if [[ $answer =~ ^[Aa-z]+$ ]]; then
        read -p "do you want to change version of your package? (yes/no/y/n)" answer
        if [ y = "$answer" ]; then
        echo "test"
        break
        elif [ n = "$answer" ]; then
        echo "test"
        break
        fi
        if
        else
        echo "Invalid input. Not a Number, Try Again"
        fi
done
if [[ $answer =~ ^[Aa-z]+$ ]]; then
        read -p "do you want to change version of your package? (yes/no/y/n)" answer
        if [ y = "$answer" ]; then