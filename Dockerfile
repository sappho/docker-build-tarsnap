FROM ubuntu:trusty

MAINTAINER Andrew Heald <andrew@heald.uk>

ARG hash
ARG tarball
ARG dependencies='curl gcc libc6-dev make libssl-dev zlib1g-dev e2fslibs-dev gnupg2'

RUN apt-get -qq update && \
    apt-get -qq -y install $dependencies

ADD tarsnap-signing-key-2016.asc /opt/

RUN gpg --import /opt/tarsnap-signing-key-2016.asc

RUN curl --fail --silent --location --retry 3 $hash > /opt/tarsnap.asc && \
    curl --fail --silent --location --retry 3 $tarball > /opt/tarsnap.tgz && \
    expected=`gpg --decrypt /opt/tarsnap.asc | awk '{print $4}'` && \
    actual=`shasum -a 256 /opt/tarsnap.tgz | awk '{print $1}'` && \
    echo ===================================== && \
    echo Expected hash = $expected && \
    echo Tarball hash  = $actual && \
    echo ===================================== && \
    if [ $actual != $expected ]; then echo 'Hash mismatch!'; exit 1; fi && \
    mkdir /opt/tarsnap && \
    cat /opt/tarsnap.tgz | tar -xz -C /opt/tarsnap --strip-components=1 && \
    cd /opt/tarsnap && \
    ./configure && \
    make all && \
    make install && \
    rm -fr /opt/* && \
    rm -fr /root/.gnupg && \
    apt-get -qq -y --auto-remove purge $dependencies && \
    apt-get clean

RUN mv -v /usr/local/etc/tarsnap.conf.sample /usr/local/etc/tarsnap.conf
