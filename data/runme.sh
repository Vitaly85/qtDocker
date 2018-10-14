#!/bin/bash
arr=(`ls | grep -e '^qt-unified[[:graph:]]*run$' | sort -f`)
position=$(( ${#arr[*]} - 1 ))
./${arr[$position]} --script script.qs
