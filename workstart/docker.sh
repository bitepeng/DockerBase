#!/usr/bin/env bash

# 启动docker私有库+UI环境

cd .. && pwd && \
docker-compose up -d docker-registry docker-humpback-web docker-humpback-agent

# 首次启动初始化db，二次启动请禁用
# cp -rf docker-humpback/initdb/* ~/.laradock/data/docker-humpback/dbFiles
