#!/bin/sh
set -e

MOUNTS_ROOT=/var/docker-apps/pge

LOG_APP=$MOUNTS_ROOT/logs/app
LOG_NGINX=$MOUNTS_ROOT/logs/nginx
PHOTOS=$MOUNTS_ROOT/photos

mkdir -p $LOG_APP $PHOTOS
chown nobody:nogroup $LOG_APP $PHOTOS

mkdir -p $LOG_NGINX

