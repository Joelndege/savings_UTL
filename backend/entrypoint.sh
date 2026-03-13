#!/bin/sh

echo "Running migrations..."
python manage.py migrate --noinput

echo "Creating superuser..."

export DJANGO_SUPERUSER_PASSWORD=$DJANGO_SUPERUSER_PASSWORD

python manage.py createsuperuser \
  --noinput \
  --username "$DJANGO_SUPERUSER_USERNAME" \
  --email "$DJANGO_SUPERUSER_EMAIL" || true

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting server..."
gunicorn config.wsgi:application --bind 0.0.0.0:$PORT