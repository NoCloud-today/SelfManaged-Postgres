#!/usr/bin/env bash
set -e

cd "$(dirname "$0")/../"

docker build ./docker-image/wal-g/ -t wal-g-shmpg