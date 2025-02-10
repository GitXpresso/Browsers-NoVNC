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
    echo "**** cleanup ****" && \
    sudo dpkg --add-architecture i386 && \
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
