#!/bin/bash
echo Tarsnap Images ...
tarsnap --list-archives | sort

# Write out cache size
echo Cache size:
du -sh /usr/local/tarsnap-cache
