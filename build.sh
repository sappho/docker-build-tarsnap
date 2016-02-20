#!/bin/bash
set -e

version=1.0.36.1
majorVersion=1.0

directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build \
  --build-arg hash=https://www.tarsnap.com/download/tarsnap-sigs-$version.asc \
  --build-arg tarball=https://www.tarsnap.com/download/tarsnap-autoconf-$version.tgz \
  -t dok.re/sappho/tarsnap:$version \
  -t dok.re/sappho/tarsnap:$majorVersion \
  -t dok.re/sappho/tarsnap:1 \
  -t dok.re/sappho/tarsnap \
  $directory

docker push dok.re/sappho/tarsnap
