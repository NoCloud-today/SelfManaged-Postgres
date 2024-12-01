#!/usr/bin/env bash
set -e

service="$1"

dir="$2"

if [ -z $service ]; then
  echo "Error: you need to specify postgres service name"
  exit 1
fi

cd "$(dirname "$0")/../$dir"

docker-compose exec $service sh -c '/wal-g backup-push -f $PGDATA'
