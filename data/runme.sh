#!/bin/bash
arr=(`ls | grep -e '^qt-unified[[:graph:]]*run$' | sort -f`)
position=$(( ${#arr[*]} - 1 ))
./${arr[$position]} -v --script script.qs DESTINATION=$DESTINATION COMPONENTS=$QT_COMPONENTS 

# TODO select appropriate Qt
#export QT_SELECT=$DESTINATION
