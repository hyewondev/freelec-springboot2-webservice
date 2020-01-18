#!/usr/bin/env bash

ABSPATH=$(readlink -f $0)
ABSDIR=$(dirname $ABSPATH)
source ${ABSDIR}/profile.sh

function switch_proxy() {
  IDLE_PORT=$(find_idle_port)

  echo "> Transfer Port: $IDLE_PORT "
  echo "> Port transferred"
  echo "set \$service_url http://127.0.01:${IDLE_PORT};" | sudo tee /etc/nginx/conf.d/service-url.inc

  echo "> NginX Reload"
  sudo service nginx reload
}