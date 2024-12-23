FROM debian:bookworm
# https://packages.debian.org/search?keywords=mariadb-server

RUN apt update && apt upgrade
RUN apt install -y mariadb-server gettext

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/
COPY init.sql /tmp/

RUN mkdir -p /run/mysqld

COPY script.sh /tmp/
RUN chmod +x /tmp/script.sh

EXPOSE 3306

VOLUME /var/lib/mysql

CMD ["/tmp/script.sh"]