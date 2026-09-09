#!/bin/sh
set -eu

cd /app/backend
python manage.py migrate --noinput
python manage.py seed_tasks || true
python manage.py runserver 127.0.0.1:8000 > /tmp/task-tracker-django.log 2>&1 &

nginx -g 'daemon off;'
