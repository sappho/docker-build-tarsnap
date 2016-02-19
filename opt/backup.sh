#!/bin/bash
echo Tarsnap Backup ...
filename=dockerregistry-`date +"%Y-%m-%d-%H-%M-%S"`
echo Filename: $filename
echo Paths:    $@
tarsnap -c -f $filename $@
