#!/bin/sh
set -e

echo "Building base image"
docker build --rm -t jtgeibel/ruby-build-deps build-deps

BASE=jtgeibel/ruby-build-deps
NAME="jtgeibel/ruby:all"
echo "Building $NAME"
ID=$(cat install-all-latest-rubies | docker run -i -a stdin "$BASE" /bin/sh)
docker wait $ID > /dev/null
ID=$(docker commit $ID)
docker tag $ID "$NAME"
docker tag jtgeibel/ruby:all jtgeibel/ruby
echo "Build success, image tagged as $NAME"

BASE=jtgeibel/ruby
NAME=jtgeibel/passenger-nginx
echo "Building $NAME"
ID=$(cat passenger-nginx-install | docker run -i -a stdin "$BASE" /bin/sh)
docker wait $ID > /dev/null
ID=$(docker commit $ID)
docker tag $ID "$NAME"
echo "Build success, image tagged as $NAME"
