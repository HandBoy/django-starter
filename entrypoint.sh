#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python src/manage.py flush --no-input
python src/manage.py migrate

if [ "$1" != "" ]; then
    exec "$@"
    exit
fi
