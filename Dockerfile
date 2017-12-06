FROM ubuntu:16.04
MAINTAINER zhouyq@goodrain.com

RUN apt-get update
Run apt-get install tzdata
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

COPY build $BUILD_DIR

RUN $BUILD_DIR/build.sh system_init

RUN $BUILD_DIR/build.sh install_packages

RUN $BUILD_DIR/build.sh install_gosu

RUN $BUILD_DIR/build.sh install_libjemalloc

RUN $BUILD_DIR/build.sh install_gifsicle

RUN $BUILD_DIR/build.sh install_pngcrush

RUN $BUILD_DIR/build.sh install_pngquant

ENV DEBUG=1

RUN $BUILD_DIR/build.sh install_ruby

RUN $BUILD_DIR/build.sh install_discourse

RUN $BUILD_DIR/build.sh install_nginx

RUN $BUILD_DIR/cleanup

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY etc /etc
COPY init_user /tmp/init_user

VOLUME /data

EXPOSE 80
    
ENTRYPOINT ["/docker-entrypoint.sh"]
