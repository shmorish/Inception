#!/bin/bash

create_database() {
    # check if /etc/mysql/init.sql already exists
    if [ -f /etc/mysql/init.sql ]; then
        echo "init.sql already exists"
    else
        echo "Generating init.sql"
        envsubst < /tmp/init.sql > /etc/mysql/init.sql
    fi
}


install() {
    # check if mysql is already installed
    if [ -d /var/lib/mysql/mysql ]; then
        echo "mysql already installed"
    else
        mysql_install_db --user=root --datadir=/var/lib/mysql
    fi
}

main() {
    create_database
    install
    exec mysqld
}

main