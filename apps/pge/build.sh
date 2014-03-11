#!/bin/sh
set -e
set -x

BASE=jtgeibel/passenger-nginx
NAME=pge

ID=$(cat inject.sh | docker run -i -a stdin "$BASE" /bin/sh)
docker wait $ID > /dev/null
ID=$(docker commit $ID)
docker tag $ID "$NAME"
docker tag $ID "$NAME":`date +%Y-%m-%d`

echo "Build success, image tagged as $NAME"
