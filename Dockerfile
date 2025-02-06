FROM bitnami/minideb:latest

RUN apt update && apt install -y wget novnc websockify tigervnc-standalone-server tar openbox libdbus-glib-1-2:amd64 libgtk2.0-0 libasound2

RUN wget https://github.com/GitXpresso/Browsers-NoVNC/releases/download/TarAndDeb/palemoon-33.5.1.linux-x86_64-gtk3.tar.xz  && sudo tar -xvf palemoon-33.5.1.linux-x86_64-gtk3.tar.xz -C /opt/ 
EXPOSE 6080
CMD ["sh", "-c", "tigervncserver -SecurityTypes none --I-KNOW-THIS-IS-INSECURE -xstartup /usr/bin/openbox -geometry 1366x768 -localhost no :0 ; websockify -D --web=/usr/share/novnc/  --cert=~/linux-novnc/novnc.pem 6080 localhost:5900 ; /opt/palemoon/palemoon --display=:0"