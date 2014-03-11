FROM stackbrew/ubuntu:13.10

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git-core curl wget python-yaml build-essential libssl-dev && \
    git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build
