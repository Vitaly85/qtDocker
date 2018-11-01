QT_COMPONENTS:=$(shell ./QtVersion.sh)

all: help 

help:
	echo 'help | build | run'

build:
	docker build --build-arg QT_COMPONENTS=$(QT_COMPONENTS) -t qtocker:v0000 .
