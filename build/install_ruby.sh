#!/bin/bash

set -ex

source $BUILD_DIR/env   
    
    add-apt-repository ppa:ubuntu-toolchain-r/test &&\
    apt-get update &&\
    apt-get install -y gcc-4.9 &&\
    (cd /usr/bin && rm gcc && ln -s gcc-4.9 gcc) &&\
    echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
    mkdir /src &&\
    cd /src && \
    git clone https://github.com/sstephenson/ruby-build.git &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build && ruby-build 2.4.2 /usr/local &&\
  
    gem update --system &&\
    gem install bundler --force &&\
    rm -rf /usr/local/share/ri/2.4.2/system