#!/usr/bin/env bash

# 关闭并删除所有docker容器和镜像

docker kill $(docker ps -q)
docker rm $(docker ps -a -q)
docker rmi $(docker images -q -a)