FROM ubuntu:14.04
MAINTAINER zhouyq@goodrain.com

RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata
RUN groupadd -r -g 200 discourse && useradd -r -u 200 -g discourse discourse

ENV  GOSU_BIN="gosu discourse"
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

RUN $BUILD_DIR/build.sh system_init

RUN $BUILD_DIR/build.sh install_packages

RUN $BUILD_DIR/build.sh install_gosu

RUN $BUILD_DIR/build.sh install_libjemalloc

RUN $BUILD_DIR/build.sh install_gifsicle

RUN $BUILD_DIR/build.sh install_pngcrush

RUN $BUILD_DIR/build.sh install_pngquant

RUN $BUILD_DIR/build.sh install_ruby

RUN $BUILD_DIR/build.sh install_discourse

RUN $BUILD_DIR/build.sh install_nginx

RUN $BUILD_DIR/cleanup

VOLUME $PERMANENT_DIR

EXPOSE 80
    
ENTRYPOINT ["/usr/local/bin/startup"]
