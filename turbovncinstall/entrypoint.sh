#!/bin/bash
set -ex

RUN_OPENBOX=${RUN_OPENBOX:-yes}
RUN_STEAM=${RUN_STEAM:-yes}

case $RUN_OPENBOX in
  false|no|n|0)
    rm -f /app/conf.d/openbox.conf
    ;;
esac

case $RUN_STEAM in
  false|no|n|0)
    rm -f /app/conf.d/steam.conf
    ;;
esac

exec supervisord -c /app/supervisord.conf
