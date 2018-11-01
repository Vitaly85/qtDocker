#!/bin/bash

if [ -f `which qtdiag` ] && [ -z $QT_COMPONENTS ]; then  
    Q_VERSION=$(qtdiag 2>/dev/null | grep -Eo 'Qt [5]{1}.[0-9]{1,2}[.]{0,1}[0-9]{0,1}' | grep -Eo '[5]{1}.[0-9]{1,2}[.]{0,1}[0-9]{0,1}')
    QT_COMPONENTS="qt.qt5."$(echo $Q_VERSION | awk '{ split($1,rez,".")}; END{ first=rez[1];second=rez[2];therd=rez[3];if(rez[2]<10)second="0"rez[2];if(!rez[3])therd="0"; print first second therd}')".gcc_64"
else
    QT_COMPONENTS="qt.qt5.5112.gcc_64"
fi

echo $QT_COMPONENTS
