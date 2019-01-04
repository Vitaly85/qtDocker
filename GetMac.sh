#/bin/bash

if [ -z $CONTEINER_MAC_ADDR ]; then
  echo "No conteiner mac address!"
  echo "Set environment variable CONTEINER_MAC_ADDR!"
  exit 1
else
  echo $CONTEINER_MAC_ADDR
fi
