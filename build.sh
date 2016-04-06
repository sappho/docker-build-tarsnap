#!/bin/bash
set -e

version=1.0.37
majorVersion=1.0

directory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker pull ubuntu:trusty

docker build \
  --build-arg hash=https://www.tarsnap.com/download/tarsnap-sigs-${version}.asc \
  --build-arg tarball=https://www.tarsnap.com/download/tarsnap-autoconf-${version}.tgz \
  -t sappho/tarsnap:$version \
  -t sappho/tarsnap:$majorVersion \
  -t sappho/tarsnap:1 \
  -t sappho/tarsnap:latest \
  $directory

docker push sappho/tarsnap:$version
docker push sappho/tarsnap:$majorVersion
docker push sappho/tarsnap:1
docker push sappho/tarsnap:latest
