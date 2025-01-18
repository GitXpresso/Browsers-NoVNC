wget https://github.com/Floorp-Projects/Floorp/releases/latest/download/floorp-11.22.0.linux-x86_64.tar.bz2 && sudo tar -xvf floorp-11.22.0.linux-x86_64.tar.bz2 -C /usr/lib

export DISPLAY=:0
/usr/lib/floorp/floorp --display=:0
echo "floorp has started go to https://localhost:5900 to access floorp in the vnc session"
