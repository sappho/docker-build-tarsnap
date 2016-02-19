#!/bin/bash
echo Tarsnap Backup ...
echo Paths:    $@
filename=$FILENAME_PREFIX-`date +"%Y-%m-%d-%H-%M-%S"`
echo Filename: $filename
tarsnap -c -f $filename $@ || tarsnap --fsck && tarsnap -c -f $filename $@
filename=$FILENAME_PREFIX-latest
echo Filename: $filename
tarsnap -c -f $filename $@ || tarsnap -d -f $filename && tarsnap -c -f $filename $@
