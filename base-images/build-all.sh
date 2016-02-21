#!/bin/sh
set -e

user=jtgeibel

sudo docker pull ubuntu:14.04

echo "Building base image"
sudo docker build --rm -t $user/ruby-build-deps build-deps

cat install-all-latest-rubies | sudo docker run -i --name building-ruby $user/ruby-build-deps /bin/sh
sudo docker commit building-ruby $user/ruby
sudo docker rm building-ruby

BASE=$user/ruby
NAME=$user/passenger-nginx
echo "Building $NAME"
cat passenger-nginx-install | sudo docker run -i --name building-passenger "$BASE" /bin/sh
sudo docker commit building-passenger "$NAME"
sudo docker rm building-passenger
echo "Build success, image tagged as $NAME"

read -p "Press Enter to push to the registry, or Ctrl+C to cancel" noop

sudo docker push $user/ruby-build-deps:latest
sudo docker push $user/ruby:latest
sudo docker push $user/passenger-nginx:latest
