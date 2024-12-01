#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../$2"

timestamp="$3"

docker-compose stop $1

rm -rf volumes/$1 # костыль

docker-compose run --rm $1 sh -c "
    /wal-g backup-fetch \$PGDATA LATEST \
    && touch \$PGDATA/recovery.signal \
    && sed -i \"s/^#recovery_target_time = ''/recovery_target_time = '$timestamp'/p\" /etc/postgresql/postgresql.conf"

docker-compose up -d $1