#!/bin/bash

set -e

[ $DEBUG ] && set -x

# update.sh auto modify
export DISCOURSE_VERSION=1.5.1
export DISCOURSE_URL="https://github.com/discourse/discourse/archive/v${DISCOURSE_VERSION}.tar.gz"

DEVELOP_PACKAGES="libffi-dev libssl-dev libyaml-dev libreadline6-dev build-essential libxslt1-dev libxml2-dev libpq-dev ruby-dev"
PACKAGES="libxml2 libyaml-0-2 imagemagick libreadline6 libjpeg-turbo-progs postgresql-client ghostscript libxslt1.1 jhead ruby git"

echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends && \
echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends && \ 
apt-get update && \
apt-get install -y --no-install-recommends vim.tiny wget sudo net-tools && \
    ca-certificates unzip runit nodejs advancecomp jpegoptim libjpeg-progs optipng && \
    $DEVELOP_PACKAGES $PACKAGES && \
rm -rf /var/lib/apt/lists/*

gem update --system
gem install bundler

/bin/bash /tmp/build/install-gosu
/bin/bash /tmp/build/install-gifsicle
/bin/bash /tmp/build/install-pngcrush
/bin/bash /tmp/build/install-pngquant
/bin/bash /tmp/build/install-libjemalloc

groupadd -rg 200 discourse
useradd  -u  200 -g 200 -rMd /home/discourse discourse && \
docker-helper create-dir discourse:discourse /app/discourse  && \
docker-helper create-dir discourse:discourse /home/discourse


cd /app

curl -sLS -o /app/discourse.tar.gz  $DISCOURSE_URL && \
tar xzf /app/discourse.tar.gz && mv discourse-$DISCOURSE_VERSION discourse && \
rm -rf /app/discourse.tar.gz

cd /app/discourse 

mkdir -p /usr/share/ruby && \
echo "image_optim_pack" > /usr/share/ruby/default-gems && \
export BUNDLE_ARGS="-j128 --without=development:test --enable-shared" && \
docker-helper install-users-gems && \

  echo libxml2     hold | dpkg --set-selections && \
  echo libpq5      hold | dpkg --set-selections && \
  echo libssl1.0.0 hold | dpkg --set-selections && \
  echo imagemagick hold | dpkg --set-selections && \
  echo ghostscript hold | dpkg --set-selections && \
  echo libxslt1.1  hold | dpkg --set-selections && \
  echo git         hold | dpkg --set-selections && \

docker-helper enable-stdout-logger && \
docker-helper apt-clean $DEVELOP_PACKAGES && \
docker-helper cleanup && \
chown -R discourse:discourse /app/discourse && \
for f in production.log unicorn.stderr.log unicorn.stdout.log; do \
  ln -sf /app/discourse/log/$f /etc/stdout.d/$f; \
done


