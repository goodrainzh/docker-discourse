#!/bin/bash

set -ex

source $BUILD_DIR/env

cd /tmp
  wget -q http://goodrain-pkg.oss-cn-shanghai.aliyuncs.com/discourse/pngquant-${PNGQUANT_VERSION}.tar.gz
  tar zxf pngquant-${PNGQUANT_VERSION}.tar.gz
  cd pngquant-${PNGQUANT_VERSION}
  ./configure
  make && make install
  cd /
  rm -fr /tmp/pngq*
  rm -fr /tmp/${PNGQUANT_VERSION}*