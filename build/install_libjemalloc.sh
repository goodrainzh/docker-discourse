#!/bin/bash

set -ex

source $BUILD_DIR/env
 
  mkdir /tmp/jemalloc && cd /tmp/jemalloc &&\
  wget -q https://github.com/goodrain-apps/docker-discourse/releases/download/package/jemalloc-${LIBJEMALLOC_VERSION}.tar.bz2 &&\
  tar -xjf jemalloc-${LIBJEMALLOC_VERSION}.tar.bz2 && cd jemalloc-${LIBJEMALLOC_VERSION} && ./configure && make &&\
  mv lib/libjemalloc.so.1 /usr/lib && cd / && rm -rf /tmp/jemalloc