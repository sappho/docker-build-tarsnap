#!/bin/bash
set -e
echo Tarsnap Restore ...
if [ -z "$1" ]; then
    image=`tarsnap --list-archives | sort | tail -n1`
else
    image=$1
fi
echo Image: $image
cd /
tarsnap -x -v -f $image
echo Image: $image
