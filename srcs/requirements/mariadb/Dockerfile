FROM debian:bookworm

ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG MYSQL_ROOT_PASSWORD

# パッケージリストを更新し、mariadb-serverとmariadb-clientをインストール
RUN apt -y update && apt -y upgrade
RUN apt -y install mariadb-server mariadb-client

# 不要なファイルを削除
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
RUN chmod 777 /var/run/mysqld

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d/
RUN chmod 644 /etc/mysql/mariadb.conf.d/mariadb.cnf
COPY ./conf/createdb.sql /usr/local/bin/

COPY ./tools/entrypoint.sh  /usr/local/bin/
RUN bash /usr/local/bin/entrypoint.sh

# ポートを公開
EXPOSE 3306

ENTRYPOINT ["mysqld_safe"]
