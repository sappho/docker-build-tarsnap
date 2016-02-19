#!/bin/bash
echo Reconstructing cache ...
tarsnap --fsck
echo Tarsnap Backup ...
echo Paths:    $@
filename=$FILENAME_PREFIX-`date +"%Y-%m-%d-%H-%M-%S"`
echo Filename: $filename
tarsnap -c -f $filename $@
filename=$FILENAME_PREFIX-latest
echo Filename: $filename
tarsnap -c -f $filename $@
