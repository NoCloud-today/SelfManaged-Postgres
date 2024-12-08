#!/usr/bin/env bash
set -e

service="postgres"

timestamp="$1"

dir="$2"

cd "$(dirname "$0")/../$dir"

docker-compose stop $service

rm -rf volumes/$service

docker-compose run --rm $service sh -c "
    /wal-g backup-fetch \$PGDATA LATEST \
    && touch \$PGDATA/recovery.signal \
    && sed -i \"s/^#recovery_target_time = ''/recovery_target_time = '$timestamp'/\" /etc/postgresql/postgresql.conf"

docker-compose up -d $service

until docker-compose exec $service pg_isready -U '$PGUSER'; do
  echo "Waiting for PostgreSQL to be ready..."
  sleep 2
done

docker-compose exec $service sh -c "
    sed -i \"s/^recovery_target_time = '$timestamp'/#recovery_target_time = ''/\" /etc/postgresql/postgresql.conf"

docker-compose exec --user postgres $service sh -c 'pg_ctl -D $PGDATA promote'

if [ ! -z "$dir" ]; then
    bash ../commands/make-basebackup.sh $service $dir
else
    bash commands/make-basebackup.sh $service
fi
