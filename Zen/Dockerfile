FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

# set version label
ARG BUILD_DATE
ARG BRAVE_VERSION
ARG VERSION
LABEL maintainer="gitxpresso"
LABEL org.opencontainers.image.source https://github.com/gitxpresso/browsers-novnc

# title
ENV TITLE=Lutris
RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Lutris_Game_Platform_%28Logo%29.svg/256px-Lutris_Game_Platform_%28Logo%29.svg.png?20190914235349 && \  apt-get update && \
  echo "**** install dependencies ****" && \
  sudo dpkg --add-architecture i386 && \
  apt-get update && \
  apt install --no-install-recommends -y curl gnupg wget libc6-i386 libc6-dev  libgl1:i386 libdrm2:i386 libgtk2.0-0 libdbus-glib-1-2 dbus-x11 && \
  wget https://github.com/lutris/lutris/releases/download/v0.5.18/lutris_0.5.18_all.deb  wget https://github.com/lutris/lutris/releases/download/v0.5.18/lutris_0.5.18_all.deb && sudo apt install -y ./lutris_0.5.18_all.deb && sudo rm -rf lutris_0.5.18_all.deb && \  
  echo "**** cleanup ****" && \
  apt-get autoclean && \
  rm -rf \
    /config/.cache \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3000

VOLUME /config
