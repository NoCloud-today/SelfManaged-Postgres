#!/usr/bin/env bash
set -e

service="postgres"

dir="$1"

cd "$(dirname "$0")/../$dir"

docker-compose up -d postgres watchtower

until docker-compose exec $service pg_isready -U '$PGUSER'; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

docker-compose up -d backup-service

if [ ! -z "$dir" ]; then
    docker-compose up -d s3
    bash ../commands/make-basebackup.sh $dir
else
    bash commands/make-basebackup.sh
fi
