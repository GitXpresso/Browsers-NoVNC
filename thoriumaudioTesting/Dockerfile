FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nobodywatchin"

# title
ENV TITLE=Brave
RUN apt update && apt install sudo wget -y
RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/chromium-logo.png && \
    wget https://github.com/Alex313031/thorium/releases/download/M128.0.6613.189/thorium-browser_128.0.6613.189_AVX.deb && apt install -y ./thorium-browser_128.0.6613.189_AVX.deb && sudo rm -rf thorium-browser_128.0.6613.189_AVX.deb && \
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
