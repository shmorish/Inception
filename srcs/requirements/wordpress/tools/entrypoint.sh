#!/bin/bash

# 環境変数が設定されているかチェック
if [ -z "$WORDPRESS_DB_NAME" ] || \
   [ -z "$WORDPRESS_DB_USER" ] || \
   [ -z "$WORDPRESS_DB_PASSWORD" ] || \
   [ -z "$WORDPRESS_DB_HOST" ]; then
  echo "ERROR: WordPress database environment variables are not set."
  exit 1
fi

# wp-config.php を生成
if [ ! -f /var/www/html/wp-config.php ]; then
  cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
  sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" /var/www/html/wp-config.php
  sed -i "s/username_here/$WORDPRESS_DB_USER/g" /var/www/html/wp-config.php
  sed -i "s/password_here/$WORDPRESS_DB_PASSWORD/g" /var/www/html/wp-config.php
  sed -i "s/localhost/$WORDPRESS_DB_HOST/g" /var/www/html/wp-config.php
fi

# php-fpm を起動
exec php-fpm7.3 -F

# その他の起動処理（必要があれば記述）

# exec "$@"