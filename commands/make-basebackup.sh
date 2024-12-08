#!/usr/bin/env bash
set -e

service="postgres"

dir="$1"

cd "$(dirname "$0")/../$dir"

docker-compose exec $service sh -c '/wal-g backup-push -f $PGDATA'
