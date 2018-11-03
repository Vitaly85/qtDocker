FROM ubuntu:18.04

MAINTAINER Vitali Adamenka <zdradnik@gmail.com>

#TODO VLC-3
ARG DESTINATION=/opt/Qt
ARG QT_COMPONENTS=qt.qt5.5112.gcc_64

RUN apt update && \
    apt install -y libdbus-1-dev libfreetype6-dev libfontconfig1-dev libx11-xcb-dev curl \
    x11-common xkb-data \
    git libblkid-dev libuuid1 mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev libegl1-mesa-dev \
    qtchooser firefox

RUN mkdir /artifacts
COPY data /artifacts
RUN cd /artifacts && chmod +x $(ls /artifacts | grep -E "^qt[[:print:]]*run$")

RUN cd /artifacts && git clone -b OpenSSL_1_0_2-stable --depth 1 --no-tags https://github.com/openssl/openssl.git && cd openssl && \
    ./Configure no-rkb5 shared zlib no-dso linux-x86_64 && make -j4 && make test

ENV LD_LIBRARY_PATH=/artifacts/openssl
ENV QT_COMPONENTS=$QT_COMPONENTS
ENV QT_SELECT=qt

ENTRYPOINT '/bin/bash'
