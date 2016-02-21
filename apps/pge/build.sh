#!/bin/sh
set -e
set -x

user=jtgeibel

BASE=$user/passenger-nginx
NAME=$user/pge

cat inject.sh | sudo docker run -i --name building-pge "$BASE" /bin/sh
sudo docker commit building-pge "$NAME"
sudo docker tag "$NAME" "$NAME":`date +%Y-%m-%d`
sudo docker rm building-pge

echo "Build success, image tagged as $NAME"
