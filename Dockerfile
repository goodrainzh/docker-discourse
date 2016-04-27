FROM ubuntu:14.04
MAINTAINER zhouyq@goodrain.com

ENV  GOSU_VERSION 1.7
ENV  GOSU_BIN="gosu rain"
ENV  APP_DIR="/app/discourse"
ENV  PERMANENT_DIR="/data"
ENV  RAILS_ENV="production"
ENV  UNICORN_WORKERS=3
ENV  UNICORN_SIDEKIQS=1
ENV  RUBY_GC_MALLOC_LIMIT=40000000

# set timezone
RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata

COPY build /tmp/build
COPY usr /usr
COPY etc /etc

RUN chmod +x /tmp/build/* && \
    /tmp/build/build.sh

VOLUME /data

EXPOSE 80
    
ENTRYPOINT ["/usr/local/bin/startup"]
