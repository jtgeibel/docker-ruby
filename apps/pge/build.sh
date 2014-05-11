#!/bin/sh
set -e
set -x

USER=jtgeibel

BASE=$USER/passenger-nginx
NAME=$USER/pge

cat inject.sh | docker run -i --name building-pge "$BASE" /bin/sh
docker commit building-pge "$NAME"
docker tag "$NAME" "$NAME":`date +%Y-%m-%d`

echo "Build success, image tagged as $NAME"
