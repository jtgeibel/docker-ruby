#!/bin/sh
set -e

user=jtgeibel

BASE=$user/ruby
NAME=$user/passenger-nginx
echo "Building $NAME"
cat passenger-nginx-install | sudo docker run -i --name building-passenger "$BASE" /bin/sh
sudo docker commit building-passenger "$NAME"
sudo docker rm building-passenger
echo "Build success, image tagged as $NAME"

read -p "Press Enter to push to the registry, or Ctrl+C to cancel" noop

sudo docker push $user/passenger-nginx:latest
