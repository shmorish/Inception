FROM debian:buster-slim

# パッケージリストを更新し、必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    wget \
    php7.3-fpm \
    php7.3-mysql \
    php7.3-curl \
    php7.3-gd \
    php7.3-xml \
    php7.3-mbstring \
    php7.3-zip \
    && rm -rf /var/lib/apt/lists/*

# PATHを設定
ENV PATH="/usr/sbin:/usr/bin:${PATH}"

# 必要なディレクトリを作成し、権限を設定
RUN mkdir -p /run/php && \
    chown www-data:www-data /run/php

# /var/www/html ディレクトリを作成
RUN mkdir -p /var/www/html

# WordPressの最新版を取得
RUN wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz

# /var/www/html に展開
RUN tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1

# 不要になったファイルを削除
RUN rm /tmp/wordpress.tar.gz

# 所有者を変更
RUN chown -R www-data:www-data /var/www/html

# パーミッションを変更
RUN chmod -R 755 /var/www/html

# PHP-FPMの設定ファイルをコピー
COPY conf/php-fpm.conf /etc/php/7.3/fpm/php-fpm.conf

# www.conf ファイルが存在することを確認
RUN mkdir -p /etc/php/7.3/fpm/pool.d \
    && touch /etc/php/7.3/fpm/pool.d/www.conf

# エントリポイントスクリプトをコピーして実行権限を付与
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php-fpm7.3", "-F"]