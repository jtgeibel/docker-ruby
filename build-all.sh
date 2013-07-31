#!/bin/sh
set -e

echo "Adding precise-security repo"
docker build -t jtgeibel/ubuntu:precise-security docker/precise-security

echo "Building base image"
docker build -t jtgeibel/ruby:build-deps docker/build-deps

BASE=jtgeibel/ruby:build-deps
NAME=jtgeibel/ruby:all
echo "Building $NAME"
ID=$(cat scripts/install-all-latest-rubies | docker run -i -a stdin "$BASE" /bin/sh)
docker wait $ID > /dev/null
ID=$(docker commit $ID)
docker tag $ID "$NAME"
echo "Build success, image tagged as $NAME"

echo "Install common gem dependencies"
docker build -t jtgeibel/ruby:common-deps docker/common-deps
docker tag jtgeibel/ruby:common-deps jtgeibel/ruby

BASE=jtgeibel/ruby
NAME=jtgeibel/passenger-nginx
echo "Building $NAME"
ID=$(cat scripts/passenger-nginx-install | docker run -i -a stdin "$BASE" /bin/sh)
docker wait $ID > /dev/null
ID=$(docker commit $ID)
docker tag $ID "$NAME"
echo "Build success, image tagged as $NAME"
