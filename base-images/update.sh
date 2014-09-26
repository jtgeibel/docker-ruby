#!/bin/sh
set -e

USER=jtgeibel

BASE=$USER/ruby
NAME=$USER/passenger-nginx
echo "Building $NAME"
cat passenger-nginx-install | docker run -i --name building-passenger "$BASE" /bin/sh
docker commit building-passenger "$NAME"
docker rm building-passenger
echo "Build success, image tagged as $NAME"

read -p "Press Enter to push to the registry, or Ctrl+C to cancel" noop

docker push $USER/passenger-nginx:latest
