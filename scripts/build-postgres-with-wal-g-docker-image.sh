#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

./scripts/build-wal-g-docker-image.sh

docker build ./docker-image/postgres-with-wal-g -t postgres-with-wal-g-shmp