FROM ubuntu:18.04

MAINTAINER Vitali Adamenka <zdradnik@gmail.com>

#TODO VLC-3
ARG QT_HIGHT=5
ARG QT_MIDLE=11
ARG QT_LOW=2
ARG QT_ADDITIONAL
ARG UID

ENV QT_PATH="/usr/local/qt"
ENV ARTIFACTS="/home/user/build"
# ARG QT_CONFIGURE="-developer-build -opensource -nomake examples -nomake tests -no-gtkstyle"
# TODO clarify configure args
ENV CONFIGURE_ARGS="-prefix $QT_PATH -opensource -confirm-license -debug -static -accessibility -qt-zlib \
-qt-libpng -qt-libjpeg -qt-xcb -qt-pcre -qt-freetype -no-glib -no-cups \
-no-sql-sqlite -no-qml-debug -no-opengl -no-egl -no-xinput2 \
-no-sm -no-icu -nomake examples -nomake tests -skip qtactiveqt -skip qtenginio \
-skip qtlocation -skip qtmultimedia -skip qtserialport -skip qtquickcontrols \
-skip qtscript -skip qtsensors -skip qtxmlpatterns -skip qt3d"

ENV QT_GIT_VERSION="v$QT_HIGHT"
ENV HELP="\n\nuse --build-arg for add specific arguments\n\
\tARG UID is essential, use `docker build -t image:v0 --build-arg UID=$(id -u) .` for basic build\n\
\tQT_MIDLE is essential, QT_MIDLE - midle qt number, `11` - default\n\
\tAdditional ARGs:\n\
\t\tQT_LOW - low qt number, Not set for default, ! be attantive,qt branches often have no low numbers, tag will be used!\n\
\t\tQT_ADDITIONAL - additionls refs identifications, a.e. rc2 in `5.11.0-rc2`\n\
\t\tPROC - your thread number, `4` - default\n\
\t\tARTIFATS - path for artifacts foldr, $ARTIFACTS - default\n\
\t\tQT_CONFIGURE - set it if you want own configure arguments; Default configure args: $QT_CONFIGURE"

# verify arguments
RUN if [ -z $UID ]; then echo "\e[31mNo UID!, set your actual uid to arg UID!"; echo "\e[32m$HELP\e[39m"; exit 1; fi
RUN if [ $QT_HIGHT != 5 ] ; then echo "\e[31mThis build is support only  Qt5!"; echo "\e[32m$HELP\e[39m"; exit 1; fi

RUN apt update && \
    apt install -y libdbus-1-dev libfreetype6-dev libfontconfig1-dev libx11-xcb-dev curl \
    x11-common xkb-data \
    libblkid-dev libuuid1 mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev libegl1-mesa-dev libxcb-shm0-dev \
    git python

# Add user
RUN useradd -G sudo,root -m -s /bin/bash -u $UID user

RUN if [ ! -z $QT_MIDLE ] ; then QT_GIT_VERSION=$QT_GIT_VERSION.$QT_MIDLE; else echo "\e[31m No Qt midle version!\e[39m"; echo "\e[32m$HELP\e[39m"; fi ; \
    if [ ${#QT_MIDLE} -ge 1 ] && [ ${#QT_LOW} -ge 1 ] ; then QT_GIT_VERSION=$QT_GIT_VERSION.$QT_LOW; else QT_GIT_VERSION=$QT_HIGHT.$QT_MIDLE; fi; \
    if [ ${#QT_MIDLE} -ge 1 ] && [ ${#QT_LOW} -ge 1 ] && [ ${#QT_ADDITIONAL} -ge 1 ] ; then QT_GIT_VERSION=$QT_GIT_VERSION-$QT_ADDITIONAL; fi; \
    su user && mkdir -p $ARTIFACTS && cd $ARTIFACTS && git clone git://code.qt.io/qt/qt5.git && \
    cd qt5 && \
    if git checkout $QT_GIT_VERSION; then echo "\e[32mCheckout Ok\e[39m"; \
                                     else echo "\e[31mNo branch or tag $QT_VERSION found"; \
                                          echo "\e[32mAvailable branch and tags:\e[39m"; git show-ref; exit 1; fi

RUN mkdir $ARTIFACTS/build
COPY data/build.sh $ARTIFACTS/build
RUN ln -s $ARTIFACTS/build/build.sh /usr/bin/qtbuild.sh

ENTRYPOINT ["qtbuild.sh"]
