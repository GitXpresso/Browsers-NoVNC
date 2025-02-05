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
      xterm \
      sudo \
      wget \
      xvfb
    
# Installing steam
RUN wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb 
RUN apt install -y ./steam.deb 
RUN apt update 
# setting rootless user
RUN useradd debian
USER debian
# Setup demo environment variables

ENV HOME=/debian \
    USER=debian \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes
COPY . /app
CMD ["/app/entrypoint.sh"]
EXPOSE 8080
