#!/bin/bash

set -e

[ $DEBUG ] && set -x
apt-get update && apt-get install make && apt-get install wget&&\
source $BUILD_DIR/functions

$1
