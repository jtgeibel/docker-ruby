#!/bin/sh
set -e
set -x

BASE=jtgeibel/passenger-nginx
NAME=pge

ID=$(cat inject.sh | docker run -i -a stdin "$BASE" /bin/sh)
docker wait $ID > /dev/null
ID=$(docker commit $ID)
docker tag $ID "$NAME"

echo "Build success, image tagged as $NAME"