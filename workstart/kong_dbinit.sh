#!/usr/bin/env bash

# 初始化kong-database

docker run --rm \
    --network=backend \
    -e "KONG_DATABASE=postgres" \
    -e "KONG_PG_HOST=cloud-kong-db" \
    -e "KONG_CASSANDRA_CONTACT_POINTS=kong-database" \
    kong:latest kong migrations up
