FROM stackbrew/ubuntu:14.04

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git-core curl wget build-essential libssl-dev libyaml-dev autoconf bison libreadline6 libreadline6-dev zlib1g zlib1g-dev && \
    git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build
