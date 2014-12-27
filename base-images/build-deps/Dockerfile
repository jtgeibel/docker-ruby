FROM ubuntu:14.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git-core curl wget build-essential libssl-dev libyaml-dev autoconf bison libreadline6 libreadline6-dev zlib1g zlib1g-dev libffi-dev && \
    apt-get install -y libpq-dev imagemagick libmagickwand-dev libcurl4-openssl-dev libpcre3 libpcre3-dev libxml2-dev libxslt-dev && \
    git clone https://github.com/sstephenson/ruby-build.git /opt/ruby-build && \
    cd /opt/ruby-build && \
    ./install.sh
