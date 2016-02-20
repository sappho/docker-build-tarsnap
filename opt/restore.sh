#!/bin/bash

echo Tarsnap Restore ...

image=$FILENAME_PREFIX-$1
echo Image: $image

cd /
tarsnap -x -f $image
