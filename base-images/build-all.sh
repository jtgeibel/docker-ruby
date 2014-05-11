#!/bin/sh
set -e

USER=jtgeibel

echo "Building base image"
docker build --rm -t $USER/ruby-build-deps build-deps

cat install-all-latest-rubies | docker run -i --name building-ruby $USER/ruby-build-deps /bin/sh
docker commit building-ruby $USER/ruby
docker tag $USER/ruby $USER/ruby:all
docker rm building-ruby

BASE=$USER/ruby
NAME=$USER/passenger-nginx
echo "Building $NAME"
cat passenger-nginx-install | docker run -i --name building-passenger "$BASE" /bin/sh
docker commit building-passenger "$NAME"
docker rm building-passenger
echo "Build success, image tagged as $NAME"

read -p "Press Enter to push to the registry, or Ctrl+C to cancel" noop

docker push jtgeibel/ruby-build-deps:latest
docker push jtgeibel/ruby:latest
docker push jtgeibel/passenger-nginx:latest
