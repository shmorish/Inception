#!/bin/sh

sleep 10

# Download Wordpress
echo "start download wordpress"
wp core download --locale=ja --allow-root --path='/var/www/html'

# SetUp wp-config
# debug message
echo "start wp-config"
wp core config \
  --path='/var/www/html' \
  --dbname=${DB_NAME} \
  --dbuser=${DB_USER} \
  --dbpass=${DB_PASS} \
  --dbhost=${DB_HOST} \
  --allow-root

# Wordpress Install
echo "start wp-install"
wp core install \
  --path='/var/www/html' \
  --url=${WP_URL} \
  --title=${WP_TITLE} \
  --admin_user=${WP_ADMIN_USER} \
  --admin_password=${WP_ADMIN_PASS} \
  --admin_email=${WP_ADMIN_EMAIL} \
  --allow-root

# Create User
echo "start wp-user-create"
wp user create \
  --path='/var/www/html' \
  ${WP_USER} \
  ${WP_USER_EMAIL} \
  --role=author \
  --user_pass=${WP_USER_PASSWORD} \
  --allow-root