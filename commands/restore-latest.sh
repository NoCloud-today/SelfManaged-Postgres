#!/usr/bin/env bash
set -e

service="postgres"

dir="$1"

cd "$(dirname "$0")/../$dir"

docker-compose stop $service
rm -rf volumes/$service/
docker-compose run --rm $service sh -c '/wal-g backup-fetch $PGDATA LATEST; touch $PGDATA/recovery.signal'
docker-compose up -d $service
