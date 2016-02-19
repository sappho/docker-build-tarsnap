#!/bin/bash

directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build \
  --build-arg hash=https://www.tarsnap.com/download/tarsnap-sigs-1.0.36.1.asc \
  --build-arg tarball=https://www.tarsnap.com/download/tarsnap-autoconf-1.0.36.1.tgz \
  -t dok.re/sappho/tarsnap:1.0.36.1 \
  -t dok.re/sappho/tarsnap:1.0.36 \
  -t dok.re/sappho/tarsnap:1.0 \
  -t dok.re/sappho/tarsnap:1 \
  -t dok.re/sappho/tarsnap \
  $directory

docker push dok.re/sappho/tarsnap:1.0.36.1
docker push dok.re/sappho/tarsnap:1.0.36
docker push dok.re/sappho/tarsnap:1.0
docker push dok.re/sappho/tarsnap:1
docker push dok.re/sappho/tarsnap
