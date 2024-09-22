FROM debian:bullseye

# パッケージリストを更新し、mariadb-serverとmariadb-clientをインストール
RUN apt -y update && apt -y upgrade
RUN apt -y install mariadb-server mariadb-client

# 不要なファイルを削除
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql /var/run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
RUN chmod 777 /var/run/mysqld

COPY ./conf/mariadb.cnf /etc/mysql/
RUN chmod 644 /etc/mysql/mariadb.cnf
COPY ./conf/createdb.sql /usr/local/bin/

EXPOSE 3306

COPY ./tools/entrypoint.sh  /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["mysqld"]