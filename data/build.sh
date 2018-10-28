#!/bin/bash

echo "------------------------------------"
echo "Qt configure args: $CONFIGURE_ARGS" 
echo "------------------------------------"

if [ ${#1} -ge 3 ] ; then
  CONFIGURE_ARGS=$1
fi
  
THREADS=$(cat /proc/cpuinfo | grep processor | wc -l)

cd $ARTIFACTS/qt5 &&
Q_VERSION=$(git branch | grep '*' | grep -Eo '[0-9]{1}\.[0-9]{1,2}\.{0,1}[0-9]{0,2}' | sed 's|\.| |g')
let QT_MIDLE=$(echo $Q_VERSION | awk '{print $2}')

if [ $QT_MIDLE -ge 8 ] ; then
  perl init-repository -f 
else 
  git submodule update --init --force --recursive
fi

if ./configure $CONFIGURE_ARGS && make -j $THREADS && make check && make install ; then 
  echo -e "----------------\nBuilded Ok!!!\n----------------------"
else
  echo "Build problem!!!" 
fi


