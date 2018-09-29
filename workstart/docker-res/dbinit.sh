#!/usr/bin/env bash

# 首次启动初始化db，二次启动请禁用
cp -rf docker-humpback/initdb/* ~/.laradock/data/docker-humpback/dbFiles
