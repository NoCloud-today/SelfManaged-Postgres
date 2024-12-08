#!/usr/bin/env bash
set -e

service="postgres"

cd "$(dirname "$0")/../"

echo "select * from pg_stat_archiver;" | docker-compose exec -T $service sh -c "psql -x -U \$POSTGRES_USER \$POSTGRES_DB -a -q -f -"
