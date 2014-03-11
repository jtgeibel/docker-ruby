#!/bin/sh

set -x

HOST_PORT=4000
HOST_IP=172.17.42.1
MOUNTS_ROOT=/home/jtgeibel/docker/bind-mounts/pge

. ./secrets.sh

LOG_APP=$MOUNTS_ROOT/logs/app
LOG_NGINX=$MOUNTS_ROOT/logs/nginx
PHOTOS=$MOUNTS_ROOT/photos

sudo mkdir -p $LOG_APP $PHOTOS
sudo chown nobody:nogroup $LOG_APP $PHOTOS

sudo mkdir -p $LOG_NGINX

docker run \
  -v $LOG_APP:/app/log \
  -v $LOG_NGINX:/var/log/nginx \
  -v $PHOTOS:/app/public/photos \
  -p 127.0.0.1:$HOST_PORT:80 \
  -e HOST_IP=$HOST_IP \
  -e DB_PG_USER=$DB_PG_USER \
  -e DB_PG_DATABASE=$DB_PG_DATABASE \
  -e DB_PG_PASS=$DB_PG_PASS \
  -e SECRET_TOKEN=$SECRET_TOKEN \
  -e AIRBRAKE_KEY=$AIRBRAKE_KEY \
  -e NEWRELIC_KEY=$NEWRELIC_KEY \
  -e AUTHSMTP_USER=$AUTHSMTP_USER \
  -e AUTHSMTP_PASS=$AUTHSMTP_PASS \
  jtgeibel/pge \
  nginx
