#!/bin/bash

function start_redis_server {
    redis-server &
}

function start_mysql {
    service mysql start
    sleep 1
}

function create_database {
    cd /service/vfc/nfvo/db/resources
    for ms in $(ls)
    do
        cd $ms/bin
        bash initDB.sh root $MYSQL_ROOT_PASSWORD 3306 127.0.0.1
        cd /service/vfc/nfvo/db/resources
    done
    cd /service
}

function run_forever {
    while [ ! -f /var/log/mysql.log ]; do
        sleep 1
    done
    tail -F /var/log/mysql.log
}

start_redis_server
start_mysql
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e " GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "flush privileges;"
# if [ ! -f dbexist.txt ]; then
#     echo 1 > dbexist.txt
#     create_database
# fi
run_forever
