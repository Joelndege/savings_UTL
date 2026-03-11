#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

echo "[$(date)] --- Starting Entrypoint Script ---"

echo "[$(date)] Running migrations..."
python manage.py migrate --noinput

echo "[$(date)] Collecting static files..."
python manage.py collectstatic --noinput

echo "[$(date)] Starting Gunicorn..."
# Use the PORT environment variable provided by Railway
exec gunicorn config.wsgi:application --bind 0.0.0.0:$PORT --access-logfile - --error-logfile -

