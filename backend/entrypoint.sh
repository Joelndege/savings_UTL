#!/bin/sh

echo "Running migrations..."
python manage.py migrate --noinput

echo "Creating superuser..."
python manage.py createsuperuser --noinput || true

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting server..."
gunicorn config.wsgi:application --bind 0.0.0.0:$PORT