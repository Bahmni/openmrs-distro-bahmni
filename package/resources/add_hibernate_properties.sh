#!/bin/bash
set -e

sed '/module.allow_web_admin/a\
c3p0.max_size=${OMRS_C3P0_MAX_SIZE}' ./startup-init.sh > ./startup-init-temp.sh

rm ./startup-init.sh
mv ./startup-init-temp.sh ./startup-init.sh
