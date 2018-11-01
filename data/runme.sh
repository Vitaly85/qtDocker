#!/bin/bash
arr=(`ls | grep -e '^qt-unified[[:graph:]]*run$' | sort -f`)
position=$(( ${#arr[*]} - 1 ))

if [ -z $DESTINATION ]; then
    DESTINATION=/opt/Qt
fi

if [ -z $QT_COMPONENTS ]; then
    QT_COMPONENTS='qt.qt5.5112.gcc_64'
fi

./${arr[$position]} -v --script script.qs DESTINATION=$DESTINATION COMPONENTS=$QT_COMPONENTS 

# TODO select appropriate Qt
#export QT_SELECT=$DESTINATION
# TODO build openssl
