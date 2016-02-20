#!/bin/bash
set -e
echo Tarsnap Backup ...
echo Paths: $@
image=$IMAGE_PREFIX-`date +"%Y-%m-%d-%H-%M-%S"`
echo Image: $image
tarsnap -c -v -f $image $@
echo Image: $image
echo Cache size:
du -sh /usr/local/tarsnap-cache
