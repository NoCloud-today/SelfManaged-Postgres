#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker-compose stop postgres
docker-compose run --rm postgres sh -c '/wal-g backup-fetch $PGDATA LATEST; touch $PGDATA/recovery.signal'
docker-compose up -d postgres