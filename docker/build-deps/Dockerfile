FROM jtgeibel/ubuntu:precise-security

RUN apt-get install -y git-core curl wget libssl1.0.0 python-yaml build-essential libssl-dev && apt-get clean
RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && cd /tmp/ruby-build && ./install.sh && cd / && rm -rf /tmp/ruby-build