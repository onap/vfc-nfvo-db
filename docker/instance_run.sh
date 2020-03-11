#!/bin/bash

function start_redis_server {
    redis-server &
}

function start_mysql {
    /usr/bin/mysqld_safe &
    sleep 10
}

function run_forever {
    while [ ! -f /var/log/mysql.log ]; do
        sleep 1
    done
    tail -F /var/log/mysql.log
}

start_redis_server
start_mysql
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "flush privileges;"
run_forever
