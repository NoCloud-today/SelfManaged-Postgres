#!/usr/bin/env bash
set -e

service="postgres"

cd "$(dirname "$0")/../"

docker exec $(docker-compose ps -q $service) sh -c "rm -rf /sqls/"
docker cp sqls/ $(docker-compose ps -q $service):/sqls/
docker-compose exec $service sh -c "cd /sqls/ && psql --quiet -U \$POSTGRES_USER \$POSTGRES_DB -f /sqls/seed.sql"