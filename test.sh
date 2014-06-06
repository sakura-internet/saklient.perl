#!/bin/bash

cd `dirname $0`
source config.sh
perl -I./lib ./test.pl "$SACLOUD_TOKEN" "$SACLOUD_SECRET"
