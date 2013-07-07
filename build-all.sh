#!/bin/sh
set -e

echo "Adding precise-security repo"
docker build -t jtgeibel/ubuntu:precise-security docker/precise-security

echo "Building base image"
docker build -t jtgeibel/ruby:build-deps docker/build-deps

echo "Installing rubies"
docker build -t jtgeibel/ruby:all docker/all

echo "Install common gem dependencies"
docker build -t jtgeibel/ruby:common-deps docker/common-deps

echo "Installing nginx with passenger"
docker build -t jtgeibel/ruby:passenger-nginx docker/passenger-nginx
