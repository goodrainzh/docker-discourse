FROM ubuntu:16.04
MAINTAINER zhouyq@goodrain.com

RUN apt-get update
RUN apt-get install tzdata
RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata
RUN groupadd -r -g 200 discourse && useradd -rM -u 200 -d /home/discourse -g discourse discourse

ENV  GOSU_BIN="gosu discourse"
ENV  APP_DIR="/opt/discourse"
ENV  PERMANENT_DIR="/data"
ENV  BUILD_DIR="/tmp/build"
ENV  RAILS_ENV="production"
ENV  UNICORN_WORKERS=3
ENV  UNICORN_SIDEKIQS=1
ENV  RUBY_GC_MALLOC_LIMIT=40000000
ENV  DEBUG=1

COPY build $BUILD_DIR

RUN $BUILD_DIR/system_init.sh

RUN $BUILD_DIR/install_packages.sh

RUN $BUILD_DIR/install_gosu.sh

RUN $BUILD_DIR/install_libjemalloc.sh

RUN $BUILD_DIR/install_gifsicle.sh

RUN $BUILD_DIR/install_pngcrush.sh

RUN $BUILD_DIR/install_pngquant.sh

RUN $BUILD_DIR/install_ruby.sh