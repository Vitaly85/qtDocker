all: build_docker build_qt docker_commit
	echo all

build_docker: Dockerfile data/build.sh
	docker build -t qtocker:v0 --build-arg UID=$$(id -u) .

build_qt:
	docker run -ti --name qtbuilder --privileged qtocker:v0

docker_commit:
	docker commit -a $$(whoami) -p -m "Docker image with builded Qt!" qtbuilder qtbuilder:v0

help:
	echo Help me!!!!


