#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Error: you need to specify postgres service name"
  exit 1
fi

cd "$(dirname "$0")/../"

docker-compose exec $1 sh -c "psql -U \$POSTGRES_USER \$POSTGRES_DB -c 'SELECT count(*) FROM contacts;'"