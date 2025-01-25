#!/bin/bash
echo "Updating Your System"
sudo apt update
echo "Installing the required packages in order for the script to work properly"
sudo apt install -y wget novnc websockify tigervnc-standalone-server tar openbox tilix
cd ~/
wget https://github.com/GitXpresso/Browsers-NoVNC/releases/download/waterfox/waterfox-6.5.3.tar.bz2 && sudo tar -xvf waterfox-6.5.3.tar.bz2 -C /usr/lib && sudo rm -rf waterfox-6.5.3.tar.bz2 
git clone https://github.com/gitxpresso/linux-novnc.git
sudo mv -f ~/waterfox/waterfox.desktop /usr/share/applications/
cat << EOF > ~/waternovnc
#!/bin/sh -e
### BEGIN INIT INFO
# Provides:          vncserver
# Required-Start:    networking
# Default-Start:     3 4 5
# Default-Stop:      0 6
### END INIT INFO

PATH="$PATH:/usr/X11R6/bin/"
sudo useradd waterfox
# The Username:Group that will run VNC
export USER="waterfox"
# Set the Display variable for firefox

#${RUNAS}

# The display that VNC will use
DISPLAY=":0"

# Color depth (between 8 and 32)
DEPTH="16"

# The Desktop geometry to use.
#GEOMETRY="<WIDTH>x<HEIGHT>"
#GEOMETRY="800x600"
GEOMETRY="1024x768"
XSTARTUP=/usr/bin/openbox
#GEOMETRY="1280x1024"

# The name that the VNC Desktop will have.
NAME="waterfox"

OPTIONS="-name ${NAME} -depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY} -xstartup ${XSTARTUP}"

. /lib/lsb/init-functions

case "$1" in
start)
log_action_begin_msg "Starting vncserver for user '${USER}' on ${DISPLAY}"
sudo su - waterfox
su ${USER} -c "/usr/bin/tigervncserver -SecurityTypes none --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 :0"
websockify -D --web=/usr/share/novnc/ --cert=~/linux-novnc/novnc.pem 6080 localhost:5900
su ${USER} -c "export DISPLAY=:0"
su ${USER} -c "/usr/lib/waterfox/waterfox --display=:0"
;;

stop)
log_action_begin_msg "Stoping vncserver for user '${USER}' on localhost:${DISPLAY}"
su ${USER} -c "/usr/bin/vncserver -kill :${DISPLAY}"
;;

restart)
$0 stop
$0 start
;;
esac

exit 0
EOF
sudo mv -f ~/waterfoxnovnc /etc/init.d
echo -e "to automatically have waterfox launch on startup do "sudo service waterfoxnovnc start" "
echo "Finished, Now go to https://localhost:5900 to access waterfox the vnc server"

