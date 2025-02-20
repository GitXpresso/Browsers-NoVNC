read -p "enter url: " URL
if [[ ! "${URL}" == *[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\-\_\/\&\?\:\.\=]* ]]; then
    echo "Invalid URL that is NOT allowed."
else
    echo "That URL is allowed."
fi