#!/usr/bin/env bash

# 关闭所有docker容器
docker kill $(docker ps -q)

cd .. && pwd && \
docker-compose down