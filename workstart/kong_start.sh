#!/usr/bin/env bash

# 启动kong服务

cd .. && pwd && \
docker-compose up -d cloud-kong-db cloud-kong
