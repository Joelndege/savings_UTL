#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting Gunicorn..."
# Use the PORT environment variable provided by Railway
exec gunicorn config.wsgi:application --bind 0.0.0.0:$PORT
