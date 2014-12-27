#!/bin/sh
set -e

user=jtgeibel

docker pull ubuntu:14.04

echo "Building base image"
docker build --rm -t $user/ruby-build-deps build-deps

cat install-all-latest-rubies | docker run -i --name building-ruby $user/ruby-build-deps /bin/sh
docker commit building-ruby $user/ruby
docker rm building-ruby

BASE=$user/ruby
NAME=$user/passenger-nginx
echo "Building $NAME"
cat passenger-nginx-install | docker run -i --name building-passenger "$BASE" /bin/sh
docker commit building-passenger "$NAME"
docker rm building-passenger
echo "Build success, image tagged as $NAME"

read -p "Press Enter to push to the registry, or Ctrl+C to cancel" noop

docker push $user/ruby-build-deps:latest
docker push $user/ruby:latest
docker push $user/passenger-nginx:latest
