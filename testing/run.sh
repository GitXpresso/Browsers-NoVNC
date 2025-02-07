#!/bin/bash
docker run -d \
  --name='zerogate_browser' \
  -e PUID=5001 \
  -e PGID=5001 \
  -e TZ=Etc/UTC \
  --shm-size="1gb" \
  -p 9009:3000 zerogate_browser:local