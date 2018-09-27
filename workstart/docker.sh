#!/usr/bin/env bash

# 启动docker私有库+UI环境

cd .. && pwd && \
docker-compose up -d docker-registry docker-humpback-web docker-humpback-agent


