# [zerogate/zerogate-browser](https://github.com/zerogate/zerogate-browser)

ZeroGate browser is an open-source secure and isolated docker image for running [Chromium](https://www.chromium.org/chromium-projects/) inside a container. It's a fork of [linuxserver/chromium](https://github.com/linuxserver/docker-chromium).

|                                Projects                                |              version              |
| :--------------------------------------------------------------------: | :-------------------------------: |
| [linuxserver/chromium](https://github.com/linuxserver/docker-chromium) | linuxserver/baseimage-alpine:3.19 |
|                                 Alpine                                 |               3.19                |
|                                Chromium                                |              latest               |
|                                KasmVNC                                 |              master               |

## Supported Architectures

The architectures supported by this image are:

| Architecture | Available | Tag                     |
| :----------: | :-------: | ----------------------- |
|    x86-64    |    ✅     | \<version tag\>         |
|    arm64     |    ✅     | arm64v8-\<version tag\> |

## Application Setup

The application websocker can be accessed at:

- ws://yourhost:3000/ws/SECRET

### Options in all KasmVNC containers

This container is based on [Docker Baseimage KasmVNC](https://github.com/linuxserver/docker-baseimage-kasmvnc) which means there are additional environment variables and run configurations to enable or disable specific functionality.

#### Optional environment variables

|  Variable   | Description                                                                                                                                                                             |
| :---------: | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|   SECRET    | The secret webscoket path. The default SECRET is a random UUID 3000.                                                                                                                    |
| CUSTOM_PORT | Internal port the container listens on for http if it needs to be swapped from the default 3000.                                                                                        |
|    TITLE    | The page title displayed on the web browser, default "KasmVNC Client".                                                                                                                  |
|   DRINODE   | If mounting in /dev/dri for [DRI3 GPU Acceleration](https://www.kasmweb.com/kasmvnc/docs/master/gpu_acceleration.html) allows you to specify the device to use IE `/dev/dri/renderD128` |

## Usage

To help you get started creating a container from this image you can either use docker-compose or the docker cli.

### docker-compose

```yaml
---
services:
  chromium:
    image: zerogate/zerogate-browser:latest
    container_name: zerogate_browser
    environment:
      - SECRET=supersecretpath
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
    ports:
      - 3000:3000
    shm_size: "1gb"
    restart: unless-stopped
```

### docker cli

```bash
docker run -d \
  --name=zerogate-browser \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SECRET=supersecretpath \
  -p 3000:3000 \
  --shm-size="1gb" \
  --restart unless-stopped \
  zerogate/zerogate-browser:latest
```

## Parameters

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

|        Parameter         | Function                                                                                                       |
| :----------------------: | -------------------------------------------------------------------------------------------------------------- |
|        `-p 3000`         | Chromium KasmVNC websocket port.                                                                               |
| `-e SECRET=<randomUUID>` | Chromium KasmVNC websocket port.                                                                               |
|      `-e PUID=1000`      | for UserID - see below for explanation                                                                         |
|      `-e PGID=1000`      | for GroupID - see below for explanation                                                                        |
|     `-e TZ=Etc/UTC`      | specify a timezone to use, see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List). |
|      `--shm-size=`       | This is needed for any modern website to function like youtube.                                                |

## GUI

This image only websocket connection of Chromium. If you want use the GUI you can use [https://github.com/kasmtech/noVNC](https://github.com/kasmtech/noVNC).
