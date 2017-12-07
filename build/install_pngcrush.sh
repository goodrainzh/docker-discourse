#!/bin/bash

set -ex

source $BUILD_DIR/env

cd /tmp
  wget -q http://goodrain-pkg.oss-cn-shanghai.aliyuncs.com/discourse/pngcrush-${PNGCRUSH_VERSION}.tar.gz
  tar zxf pngcrush-$PNGCRUSH_VERSION.tar.gz
  cd pngcrush-$PNGCRUSH_VERSION
  make && cp -f pngcrush /usr/local/bin
  cd /
  rm -fr /tmp/pngcrush-$PNGCRUSH_VERSION
  rm /tmp/pngcrush-$PNGCRUSH_VERSION.tar.gz