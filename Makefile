QT_COMPONENTS:=$(shell ./QtVersion.sh)

all: help 

help:
	echo 'help | build | run | start'

build:
	docker build --build-arg QT_COMPONENTS=$(QT_COMPONENTS) -t qtocker:v0000 .

run:
	echo TODO

start:
	echo TODO
