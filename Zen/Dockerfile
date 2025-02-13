FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm

# set version label
ARG BUILD_DATE
ARG BRAVE_VERSION
ARG VERSION
LABEL maintainer="gitxpresso"
LABEL org.opencontainers.image.source https://github.com/gitxpresso/browsers-novnc

# title
ENV TITLE=Zen

RUN \
  echo "**** add icon ****" && \
  curl -o \
    /kclient/public/icon.png \
    https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Zen_Browser_logo_%28red_circles%29.svg/320px-Zen_Browser_logo_%28red_circles%29.svg.png?20241210152321 && \
  apt-get update && \
  echo "**** install dependencies ****" && \
  apt install --no-install-recommends -y curl gnupg wget && \
  wget https://github.com/zen-browser/desktop/releases/download/1.7.6b/zen.linux-x86_64.tar.xz && tar -xvf zen.linux-x86_64.tar.xz -C ~/ && sudo rm -f zen.linux-x86_64.tar.xz && \
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
