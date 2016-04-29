#!/bin/bash

set -e

[ $DEBUG ] && set -x

source $BUILD_DIR/functions

system_init

install_packages

install_gosu

install_libjemalloc

install_gifsicle

install_pngcrush

install_pngquant

install_ruby

install_discourse
