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

# set timezone
RUN echo "Asia/Shanghai" > /etc/timezone;dpkg-reconfigure -f noninteractive tzdata

COPY build /tmp/build
COPY usr /usr
COPY etc /etc

RUN /tmp/build/install-packages
RUN /tmp/build/install-ruby
RUN /tmp/build/install-discourse
RUN /tmp/build/install-gosu
RUN /tmp/build/install-libjemalloc
RUN /tmp/build/install-pngcrush
RUN /tmp/build/install-gifsicle
RUN /tmp/build/install-pngquant

VOLUME /data

EXPOSE 80
    
ENTRYPOINT ["/usr/local/bin/startup"]
