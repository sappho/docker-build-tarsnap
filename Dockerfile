FROM ubuntu:trusty

MAINTAINER Andrew Heald <andrew@heald.uk>

ARG hash
ARG tarball

RUN apt-get -qq update && \
    apt-get -qq -y install curl gcc libc6-dev make libssl-dev zlib1g-dev e2fslibs-dev gnupg2 && \
    apt-get clean

ADD tarsnap-signing-key-2016.asc /opt/

RUN gpg --import /opt/tarsnap-signing-key-2016.asc

RUN curl --fail --silent --location --retry 3 $hash > /opt/tarsnap.asc && \
    curl --fail --silent --location --retry 3 $tarball > /opt/tarsnap.tgz && \
    gpg --decrypt /opt/tarsnap.asc && \
    shasum -a 256 /opt/tarsnap.tgz && \
    mkdir /opt/tarsnap && \
    cat /opt/tarsnap.tgz | tar -xz -C /opt/tarsnap --strip-components=1

RUN cd /opt/tarsnap && \
    ./configure && \
    make all && \
    make install

RUN rm -fr /opt/* \
    apt-get -y purge curl gcc libc6-dev make libssl-dev zlib1g-dev e2fslibs-dev gnupg2
    apt-get clean
