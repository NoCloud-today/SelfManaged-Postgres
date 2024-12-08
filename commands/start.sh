#!/usr/bin/env bash
set -e

service="postgres"

dir="$1"

cd "$(dirname "$0")/../$dir"

docker-compose up -d

until docker-compose exec $service pg_isready -U '$PGUSER'; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

cd "$(dirname "$0")"

bash make-basebackup.sh postgres $dir