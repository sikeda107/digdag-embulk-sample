#!/bin/sh
set -e
host="$1"
shift
cmd="$@"
until PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -U $DB_USERNAME -c '\q'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done
>&2 echo "Postgres is up - executing command"
exec $cmd