#!/bin/bash
echo Fix Tarsnap Cache ...
tarsnap --fsck
echo Cache size:
du -sh /usr/local/tarsnap-cache
