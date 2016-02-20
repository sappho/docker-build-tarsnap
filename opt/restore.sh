#!/bin/bash
echo Tarsnap Restore ...
image=`tarsnap --list-archives | sort | tail -n1`
echo Image: $image
cd /
tarsnap -x -v -f $image
echo Image: $image
