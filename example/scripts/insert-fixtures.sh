#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then
  echo "Error: you need to specify postgres service name"
  exit 1
fi

cd "$(dirname "$0")/../"

docker exec $(docker-compose ps -q $1) sh -c "rm -rf /sqls/"
docker cp sqls/ $(docker-compose ps -q $1):/sqls/
docker-compose exec $1 sh -c "cd /sqls/ && psql --quiet -U \$POSTGRES_USER \$POSTGRES_DB -f /sqls/fixtures.sql"