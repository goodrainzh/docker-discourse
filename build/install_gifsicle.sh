#!/bin/bash

set -ex

source $BUILD_DIR/env

cd /tmp
  wget -q http://goodrain-pkg.oss-cn-shanghai.aliyuncs.com/discourse/gifsicle-${GIFSICLE_VERSION}.tar.gz
  tar -zxf gifsicle-${GIFSICLE_VERSION}.tar.gz
  cd gifsicle-${GIFSICLE_VERSION}
  ./configure
  make install
  cd /
  rm -fr /tmp/gifsicle*