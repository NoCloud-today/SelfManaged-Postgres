#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Error: you need to specify postgres service name"
  exit 1
fi

echo "Restoring $1"

cd "$(dirname "$0")/../"

docker-compose stop $1
rm -rf volumes/$1/
docker-compose run --rm $1 sh -c '/wal-g backup-fetch $PGDATA LATEST; touch $PGDATA/recovery.signal'
docker-compose up -d $1
