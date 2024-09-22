FROM debian:bullseye

RUN apt -y update && apt -y upgrade
RUN apt -y install wget php7.4-fpm php7.4-mysql mariadb-client curl

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

RUN mkdir -p /var/www/html
RUN chmod -R 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY ./conf/wp-config.php /var/www/html/wp-config.php

# wp-cliのインストール
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp && \
    wp --info

# Copy Entrypoint
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh

# php-fpm の起動
ENTRYPOINT  [ "bash", "/usr/local/bin/entrypoint.sh" ]

CMD ["php-fpm7.4", "-F"]