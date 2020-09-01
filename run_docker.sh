#!/usr/bin/env bash

docker build -t nginx-web-server:0.0.3 .

docker image ls

docker run --publish 8000:80 --detach --name nginx-web-server nginx-web-server:0.0.3

