clear
while true; do
        read -p "enter the version of your package: " Version
        if [[ $Version =~ ^[0-9]+$ ]]; then
            clear
            echo "The version of your package you've entered: $Version"
        if [[ $answer =~ ^[0-9]+$ ]]; then
            read -p "do you want to change version of your package? (yes/no/y/n)" answer
        if [ y = "$answer" ]; then
            echo "changing version of package"
            clear
            bash ./test2.sh 
        elif [ n = "$answer" ]; then
            echo "not changing package version: $Version"
            break
        if 
            [ yes = "$answer" ]; then
            echo "changing version of package"
            clear
            bash ./test2.sh
        elif [ no = "$answer" ]; then
            echo "not changing package version: $Version"
            break       
        else
            echo "Invalid input. Not a Number, Try Again"
        fi
    fi
done      