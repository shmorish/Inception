# Debian Buster のイメージを取得
FROM debian:buster-slim

# パッケージリストを更新
RUN apt-get update

# nginx をインストール
RUN apt-get install -y \
    nginx 

# 不要なファイルを削除
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# nginx のデフォルト設定ファイルを削除
RUN rm /etc/nginx/sites-enabled/default

# netcat をインストール
RUN apt-get update && apt-get install -y netcat-openbsd

# 設定ファイルをコピー
COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# エントリポイントを設定
COPY ./tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# ポートを公開
EXPOSE 80