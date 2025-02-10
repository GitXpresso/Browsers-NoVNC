FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

LABEL org.opencontainers.image.source https://github.com/gitxpresso/browsers-novnc
# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="gitxpresso"


# title
ENV TITLE=Waterfox

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/chromium-logo.png && \  
    sudo apt install curl apt-transport-https libc6 -y && \
    curl -fsSL https://download.opensuse.org/repositories/home:hawkeye116477:waterfox/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_hawkeye116477_waterfox.gpg > /dev/null && \
    echo 'deb https://download.opensuse.org/repositories/home:/hawkeye116477:/waterfox/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:hawkeye116477:waterfox.list && \
    sudo apt install -y waterfox-g && \
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
