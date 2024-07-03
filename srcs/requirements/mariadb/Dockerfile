FROM debian:buster-slim

# パッケージリストを更新
RUN apt-get update

# 必要最低限のパッケージのみインストール
RUN apt-get install -y mariadb-server mariadb-client

# 不要なファイルを削除
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# 設定ファイルをコピー (後述)
COPY ./conf/my.cnf /etc/mysql/mariadb.conf.d/my.cnf

# データベースの初期化 & ルートパスワード設定
COPY ./tools/entrypoint.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/*

# ポートを公開
EXPOSE 3306

# コマンドはデフォルトを使用
#ENTRYPOINT ["docker-entrypoint.sh"]
#CMD ["mysqld"]