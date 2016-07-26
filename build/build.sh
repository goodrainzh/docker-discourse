#!/bin/bash

set -e

[ $DEBUG ] && set -x

source $BUILD_DIR/functions

$1
