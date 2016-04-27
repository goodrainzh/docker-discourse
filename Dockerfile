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

RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && apt-get update \
 && apt-get install -y --no-install-recommends vim.tiny wget sudo net-tools \
 && ca-certificates unzip runit libffi-dev libssl-dev libyaml-dev \
 && libreadline6-dev build-essential libxslt1-dev libxml2-dev libpq-dev \
 && ruby-dev libxml2 libyaml-0-2 imagemagick libreadline6 \
 && libjpeg-turbo-progs postgresql-client ghostscript libxslt1.1 gifsicle \
 && jhead ruby git nodejs advancecomp jhead jpegoptim libjpeg-progs optipng
 && rm -rf /var/lib/apt/lists/*
 
# install gosu
RUN set -x \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

COPY build /tmp/build
COPY usr /usr
COPY etc /etc

VOLUME /data

EXPOSE 80
    
ENTRYPOINT ["/usr/local/bin/startup"]
