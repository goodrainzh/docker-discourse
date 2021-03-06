#!/bin/bash

set -ex

source $BUILD_DIR/env

  for dir in /var/log/nginx /var/nginx/cache
  do
    [ ! -d $dir ] && mkdir -p $dir
    chown discourse.discourse $dir
  done

  rm -rf /etc/nginx/sites-enabled/*