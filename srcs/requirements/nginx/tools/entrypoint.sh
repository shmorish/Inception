#!/bin/bash

# nginx と php-fpm が起動するまで待機
while ! nc -z wordpress 9000; do
  echo "Waiting for php-fpm..."
  sleep 1
done

# nginx をフォアグラウンドで起動
nginx -g "daemon off;"