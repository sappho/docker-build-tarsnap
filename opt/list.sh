#!/bin/bash
echo Tarsnap Images ...
tarsnap --list-archives | sort
echo Cache size:
du -sh /usr/local/tarsnap-cache
