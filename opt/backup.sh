#!/bin/bash

echo Tarsnap Backup ...
echo Paths: $@

# Create a timestamped backup
filename=$FILENAME_PREFIX-`date +"%Y-%m-%d-%H-%M-%S"`
echo Filename: $filename
tarsnap -c -f $filename $@ || tarsnap --fsck && tarsnap -c -f $filename $@

# Also create a same-name latest backup to make a restore to latest easy
filename=$FILENAME_PREFIX-latest
echo Filename: $filename
tarsnap -c -f $filename $@ || tarsnap -d -f $filename && tarsnap -c -f $filename $@

# Write out cache size
echo Cache size:
du -sh /usr/local/tarsnap-cache
