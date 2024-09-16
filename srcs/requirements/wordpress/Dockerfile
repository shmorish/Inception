FROM debian:bookworm

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD

RUN apt -y update && apt -y upgrade
RUN apt -y install wget php7.4-fpm php7.4-mysql mariadb-client

# redis chache (bonus)
RUN apt -y install php7.4-redis redis-tools

# PHPの設定ファイルをバックアップ
RUN mv /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.bak
# PHPの設定ファイル
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/
RUN ln -s $(find /usr/sbin -name 'php-fpm*') /usr/bin/php-fpm

# ポートを公開
EXPOSE 9000

# php ディレクトリ作成
RUN mkdir -p /run/php
RUN chmod 755 /run/php

# WORDPRESSのダウンロード
RUN wget https://ja.wordpress.org/latest-ja.tar.gz
RUN tar -xvf latest-ja.tar.gz
RUN mkdir -p /var/www/html
RUN mv wordpress/* /var/www/html/
RUN rm -rf latest-ja.tar.gz

RUN chown -R www-data:www-data /var/www/html

# wp-cliのインストール
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp
RUN wp config set DB_NAME $MYSQL_DATABASE --allow-root --path=/var/www/html
RUN wp config set DB_USER $MYSQL_USER --allow-root --path=/var/www/html
RUN wp config set DB_PASSWORD $MYSQL_PASSWORD --allow-root --path=/var/www/html
RUN wp config set DB_HOST mariadb --allow-root --path=/var/www/html

# Redisの設定
RUN wp config set WP_REDIS_PORT 6379 --allow-root --path=/var/www/html
RUN wp config set WP_REDIS_HOST redis --allow-root --path=/var/www/html

# キャッシュの設定
RUN wp config set WP_CACHE true --add --type=constant --allow-root --path=/var/www/html

# Copy Entrypoint
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh

# php-fpm の起動
ENTRYPOINT  [ "bash", "/usr/local/bin/entrypoint.sh" ]