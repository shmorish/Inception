FROM debian:latest

RUN apt update && apt upgrade
RUN apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY init.sql /etc/mysql/.
COPY script.sh /tmp/.

RUN mkdir -p /run/mysqld

RUN chmod +x /tmp/script.sh
CMD ["/tmp/script.sh"]