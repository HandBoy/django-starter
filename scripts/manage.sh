#!/usr/bin/env bash
docker-compose run web python src/manage.py "$*"
