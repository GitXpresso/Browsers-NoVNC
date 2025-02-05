#!/bin/bash
set -ex

RUN_FLUXBOX=${RUN_FLUXBOX:-yes}
RUN_STEAM=${RUN_STEAM:-yes}

case $RUN_FLUXBOX in
  false|no|n|0)
    rm -f /app/conf.d/fluxbox.conf
    ;;
esac

case $RUN_STEAM in
  false|no|n|0)
    rm -f /app/conf.d/steam.conf
    ;;
esac

exec supervisord -c /app/supervisord.conf
