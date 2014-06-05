#!/bin/bash

cd `dirname $0`
source config.sh
./test.pl "$SACLOUD_TOKEN" "$SACLOUD_SECRET"
