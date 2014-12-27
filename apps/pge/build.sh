#!/bin/sh
set -e
set -x

user=jtgeibel

BASE=$user/passenger-nginx
NAME=$user/pge

cat inject.sh | docker run -i --name building-pge "$BASE" /bin/sh
docker commit building-pge "$NAME"
docker tag "$NAME" "$NAME":`date +%Y-%m-%d`
docker rm building-pge

echo "Build success, image tagged as $NAME"
