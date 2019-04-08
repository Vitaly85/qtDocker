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

HELP="can't find Qt5 installation folder in $DESTINATION, \n \
  use manual qtchooser to cet correct name(name 'qt' is used by default )"

FOLDERS=$(ls $DESTINATION | grep '5.')

if [ ${#FOLDERS} -le 1 ]; then
  echo -e $HELP
  exit 1
fi

FOLDER=$(echo $FOLDERS | awk '{ split($1,rez," ")} END{print rez[1]}')

if [ ${#FOLDER} -le 1 ]; then
  echo -e $HELP
  exit 1
fi

if [ -f $DESTINATION/$FOLDER/gcc_64 ]; then
  echo we look for gcc_64 version by default, you sould set other version manually.
  exit 1
fi

qtchoolser -install -f qt $DESTINATION/$FOLDER/gcc_64/bin/qmake

echo -e "qtchooser name qt is set by default, see 'qtchooser --help' for change it."

echo 'export PATH=$PATH:/opt/Qt/Tools/QtCreator/bin/' >> /home/user/.bashrc
echo 'cd ~' >> /home/user/.bashrc
