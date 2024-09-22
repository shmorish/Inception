#!/bin/sh

sleep 10

# Download Wordpress
wp core download --locale=ja --allow-root --path='/var/www/html'

# SetUp wp-config
wp core config \
  --path='/var/www/html' \
  --dbname=${DB_NAME} \
  --dbuser=${DB_USER} \
  --dbpass=${DB_PASSWORD} \
  --dbhost=${DB_HOST} \
  --allow-root

# Wordpress Install
wp core install \
  --path='/var/www/html' \
  --url=${WP_URL} \
  --title=${WP_TITLE} \
  --admin_user=${WP_ADMIN_USER} \
  --admin_password=${WP_ADMIN_PASSWORD} \
  --admin_email=${WP_ADMIN_EMAIL} \
  --allow-root

wp user create \
  --path='/var/www/html' \
  ${WP_USER} \
  ${WP_USER_EMAIL} \
  --role=author \
  --user_pass=${WP_USER_PASSWORD} \
  --allow-root