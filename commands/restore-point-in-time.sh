#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

timestamp="$1 $2"

docker-compose stop postgres

docker-compose run --rm postgres sh -c "\
    /wal-g backup-fetch $PGDATA LATEST \
    && touch $PGDATA/recovery.signal \
    && sed -ri \"s/^#recovery_target_time = ''/#recovery_target_time = '$timestamp'/\" /etc/postgresql/postgresql.conf"

docker-compose up -d postgres