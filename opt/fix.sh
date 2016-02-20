#!/bin/bash
echo Fixing Tarsnap cache with prune ...
tarsnap --fsck-prune

# Write out cache size
echo Cache size:
du -sh /usr/local/tarsnap-cache
