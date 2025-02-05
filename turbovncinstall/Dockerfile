FROM debian:bullseye

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      tilix \
      tigervnc-standalone-server \
      openbox \
      sudo \
      curl \
      xvfb

RUN sudo add-apt-repository multiverse \
 sudo apt update \   
 sudo apt install steam  
# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_STEAM=yes \
    RUN_TILIX=yes \ 
    RUN_OPENBOX=yes
COPY . /app
CMD ["/app/entrypoint.sh"]
EXPOSE 8080
