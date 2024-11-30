#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Error: you need to specify postgres service name"
  exit 1
fi

cd "$(dirname "$0")/../"

echo "select * from pg_stat_archiver;" | docker-compose exec -T $1 sh -c "psql -x -U \$POSTGRES_USER \$POSTGRES_DB -a -q -f -"
