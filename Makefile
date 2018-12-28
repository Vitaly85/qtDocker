QT_COMPONENTS:=$(shell ./QtVersion.sh)
MAC_ADDR:=(shell ./GetMac.sh)
SHARED_DIR:=(shell ./GetSharedDir.sh)
QTOCKER_VERSION:=(shell ./GetQtockerVersion.sh)

all: help 

help:
	echo 'help | build | run | start'

build:
	docker build --build-arg QT_COMPONENTS=$(QT_COMPONENTS) -t qtocker:v$(QTOCKER_VERSION) .

run:
	docker run --privileged -ti --rm --mac-address=$(MAC_ADDR) -e DISPLAY=$(DISPLAY) -e XDG_RUNTIME_DIR=/run/user/1000 -v /tmp/.X11-unix:/tmp/.X11-unix -v $(SHARED_DIR):$(SHARED_DIR) qtocker:v$(QTOCKER_VERSION)

start:
	echo TODO
