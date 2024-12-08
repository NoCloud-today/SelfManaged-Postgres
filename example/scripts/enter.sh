#!/usr/bin/env bash
set -e

service="postgres"

cd "$(dirname "$0")/../"

docker-compose exec $service sh -c "psql -U \$POSTGRES_USER \$POSTGRES_DB"