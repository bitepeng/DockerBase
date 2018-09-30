#!/usr/bin/env bash

# 启动php环境

cd .. && pwd && \
docker-compose up -d nginx mysql phpmyadmin redis workspace

docker-compose up -d nginx workspace

