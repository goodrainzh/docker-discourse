#!/bin/bash

set -ex

source $BUILD_DIR/env

echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends && \
  echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends

  apt-get update && \
  apt-get install -y --no-install-recommends vim.tiny wget sudo net-tools expect curl \
      ca-certificates unzip runit advancecomp jpegoptim optipng \
      $DEVELOP_PACKAGES $PACKAGES

  #node.js
  curl --silent --location https://deb.nodesource.com/setup_4.x | sudo bash -
  apt-get install  -y nodejs && \
  npm install uglify-js -g && \
  npm install svgo -g

  apt-get install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" -y nginx

  # install postgresql-client for discourse backup database      discourse后台默认数据库
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' > /etc/apt/sources.list.d/pgdg.list && \
  apt-get update && \
  apt-get install -y postgresql-client-${PG_VERSION}

  rm -rf /var/lib/apt/lists/*

  # TODO check when binary packages are ready (not yet)
  wget -q http://goodrain-pkg.oss-cn-shanghai.aliyuncs.com/discourse/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
      tar -xjf phantomjs-2.1.1-linux-x86_64.tar.bz2 &&\
      rm phantomjs-2.1.1-linux-x86_64.tar.bz2 &&\
      cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /bin/phantomjs &&\
      rm -fr phantomjs-2.1.1-linux-x86_64