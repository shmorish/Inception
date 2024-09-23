#!/bin/bash

set -eu -o pipefail
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

server_start() {
    mysqld -u root &
    local i
    for i in {10..0}; do
        if echo 'SELECT 1' | mysql &> /dev/null; then
            break
        fi
        sleep 1
    done
}

server_start

if [ ! -d "/var/lib/mysql/wordpress" ]; then
    mysql << EOS
        CREATE DATABASE $MYSQL_DATABASE;
        CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASS';
        GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASS';
        FLUSH PRIVILEGES;
EOS
fi

mysqladmin shutdown

exec "$@"
