FROM ubuntu:18.04

MAINTAINER Vitali Adamenka <zdradnik@gmail.com>

#TODO QT_version
#TODO QT_PATH
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

ENTRYPOINT '/bin/bash'
