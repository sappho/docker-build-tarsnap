#!/bin/bash
echo Reconstructing cache ...
tarsnap --fsck
echo Tarsnap Backup ...
filename=$FILENAME_PREFIX-`date +"%Y-%m-%d-%H-%M-%S"`
echo Filename: $filename
echo Paths:    $@
tarsnap -c -f $filename $@
