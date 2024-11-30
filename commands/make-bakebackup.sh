#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Error: you need to specify postgres service name"
  exit 1
fi

cd "$(dirname "$0")/../$2"

docker-compose exec $1 sh -c '/wal-g backup-push -f $PGDATA'
