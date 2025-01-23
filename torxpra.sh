
mkdir -p ~/.xdg 
mkdir -p ~/.Xauthority 
xpra start --no-daemon --bind-tcp=0.0.0.0:8989 -dbus-launch=no --start=openbox --socket-dir=~/.xdg :0
