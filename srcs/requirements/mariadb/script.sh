#!/bin/bash

envsubst < /tmp/init.sql > /etc/mysql/init.sql

mysql_install_db
mysqld