#!/usr/bin/env bash

# 启动docker-web的agent

cd .. && cd .. &&  pwd && \
docker-compose up -d docker-humpback-agent
