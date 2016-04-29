FROM ubuntu:14.04
MAINTAINER zhouyq@goodrain.com

ENV  GOSU_BIN="gosu rain"
ENV  APP_DIR="/app/discourse"
ENV  PERMANENT_DIR="/data"
ENV  BUILD_DIR="/tmp/build"
ENV  RAILS_ENV="production"
ENV  UNICORN_WORKERS=3
ENV  UNICORN_SIDEKIQS=1
ENV  RUBY_GC_MALLOC_LIMIT=40000000

COPY build $BUILD_DIR
COPY usr /usr
COPY etc /etc

RUN $BUILD_DIR/build.sh

VOLUME $PERMANENT_DIR

EXPOSE 80
    
ENTRYPOINT ["/usr/local/bin/startup"]
