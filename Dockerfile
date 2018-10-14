FROM ubuntu:18.04

MAINTAINER Vitali Adamenka <zdradnik@gmail.com>

#TODO VLC-3
ARG QT_HIGHT=5
ARG QT_MIDLE=11
ARG QT_LOW=2
ARG QT_PATH="/artifacts/qtbase"

# ARG QT_CONFIGURE="-developer-build -opensource -nomake examples -nomake tests"
# TODO clarify configure args
ARG QT_CONFIGURE="-prefix $QT_PATH -opensource -confirm-license -debug -static -accessibility -qt-zlib
                 -qt-libpng -qt-libjpeg -qt-xcb -qt-pcre -qt-freetype -no-glib -no-cups
                 -no-sql-sqlite -no-qml-debug -no-opengl -no-egl -no-xinput2
                 -no-sm -no-icu -nomake examples -nomake tests -skip qtactiveqt -skip qtenginio
                 -skip qtlocation -skip qtmultimedia -skip qtserialport -skip qtquick1 -skip qtquickcontrols
                 -skip qtscript -skip qtsensors -skip qtxmlpatterns -skip qt3d -no-gtkstyle"
ARG PROCS=$(cat /proc/cpuinfo | grep proc | wc -l)

RUN apt update && \
    apt install -y libdbus-1-dev libfreetype6-dev libfontconfig1-dev libx11-xcb-dev curl \
    x11-common xkb-data \
    libblkid-dev libuuid1 mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev libegl1-mesa-dev \
    git

# build Qt
# !!!Note: init-repository is currently unable to initialize tags that are too old. An alternative way to build a specific release or branch of Qt5 (although without linking of the gerrit account for code reviewing) is to use git submodule update --init in place of the init-repository script. That translates to:
# TODO form old tags use git submodule update --init --recursive
RUN mkdir /artifacts && cd /artifacts && git clone git clone git://code.qt.io/qt/qt5.git && \
    cd qt5 && git checkout "$QT_HIGHT.$QT_MIDLE.$QT_LOW" && perl init-repository && ./configure "$QT_CONFIGURE" && \
    make -j$PROCS && make check && make install

#COPY data /artifacts
#RUN cd /artifacts && chmod +x $(ls /artifacts | grep -E "^qt[[:print:]]*run$")

ENTRYPOINT '/bin/bash'
