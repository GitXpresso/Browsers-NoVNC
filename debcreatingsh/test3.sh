if [[ ! "${URL}" == *[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890\-\_\/\&\?\:\.\=]* ]]; then
    echo "That URL is NOT allowed."
else
    echo "That URL is allowed."
fi