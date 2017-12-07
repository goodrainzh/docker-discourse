#!/bin/bash

set -ex

source $BUILD_DIR/env

  mkdir -p /opt && cd /opt
  curl -sLS -o /opt/statics.tar.gz $DISCOURSE_STATIC && \
  curl -sLS -o /opt/discourse.tar.gz  $DISCOURSE_URL && \
  tar xzf /opt/discourse.tar.gz && mv discourse-$DISCOURSE_VERSION discourse && \
  rm -rf /opt/discourse.tar.gz

  cd $APP_DIR

  bundle install --deployment --without test --without development

  chown -R discourse:discourse $APP_DIR

  [ ! -d ${APP_DIR}/log ] && gosu discourse mkdir -pv ${APP_DIR}/log

  for f in production.log unicorn.stderr.log unicorn.stdout.log
  do
    [ ! -f $APP_DIR/log/$f ] && touch ${APP_DIR}/log/$f
  done

  chown discourse.discourse ${APP_DIR}/log/*