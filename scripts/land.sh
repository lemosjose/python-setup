#!/bin/sh

# talvez troque se for utilizar outra imagem docker que não o alpine

#encerra a execução se o script falhar
set -e



while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
  echo "Esperando o Banco de Dados PostgreSQL"
  sleep 2
done

python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py runserver 0.0.0.0:8000
