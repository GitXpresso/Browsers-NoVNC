FROM ghcr.io/linuxserver/baseimage-kasmvnc:debianbookworm
LABEL org.opencontainers.image.source https://github.com/gitxpresso/browsers-novnc
FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy AS opt

ADD https://cdn1.waterfox.net/waterfox/releases/6.5.4/Linux_x86_64/waterfox-6.5.4.tar.bz2 /waterfox-6.5.4.tar.bz2 

FROM ubuntu:jammy AS installer

# Retrieve .NET Runtime
RUN --mount=from=opt,target=/opt <<EOF
mkdir -p /dotnet
tar -oxzf /opt/waterfox-6.5.4.tar.bz2 -C /waterfox
EOF

FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy


COPY --from=installer /waterfox /opt/waterfox
RUN ln -s /opt/waterfox/waterfox /usr/bin/waterfox

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
