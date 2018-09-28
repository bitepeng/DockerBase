#!/usr/bin/env bash

# 启动kong服务

docker run --rm -p 8083:8080 pgbi/kong-dashboard start \
  --kong-url http://120.79.117.198:8001 \
  --basic-auth admin=admin888