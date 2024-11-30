#!/usr/bin/env bash
set -ex

cd "$(dirname "$0")/wal-g/"

docker build . -t wal-g-shmpg:latest

cd "../postgres-with-wal-g/"

docker build . -t postgres-with-wal-g-shmpg:15
