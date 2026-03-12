#!/bin/sh

echo "Running migrations..."
python3 manage.py migrate --noinput

echo "Collecting static files..."
python3 manage.py collectstatic --noinput

echo "Starting server..."
gunicorn config.wsgi:application --bind 0.0.0.0:$PORT