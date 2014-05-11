#!/bin/sh
set -e

echo "Building base image"
docker build --rm -t jtgeibel/ruby-build-deps build-deps

cat install-all-latest-rubies | docker run -i --name building-ruby jtgeibel/ruby-build-deps /bin/sh
docker commit building-ruby jtgeibel/ruby
docker tag jtgeibel/ruby jtgeibel/ruby:all
docker rm building-ruby

BASE=jtgeibel/ruby
NAME=jtgeibel/passenger-nginx
echo "Building $NAME"
cat passenger-nginx-install | docker run -i --name building-passenger "$BASE" /bin/sh
docker commit building-passenger "$NAME"
docker rm building-passenger
echo "Build success, image tagged as $NAME"
