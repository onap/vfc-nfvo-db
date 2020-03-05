#!/bin/bash

add_user(){

        useradd onap
	chown onap:onap -R /service
}

install_sf(){
	
	sed -i "s|set compatible|set nocompatible|" /etc/vim/vimrc.tiny
	echo "set backspace=2" >> /etc/vim/vimrc.tiny

	echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
	echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
	
	apt-get update
        apt-get install -y gcc libmysqlclient-dev redis-server mysql-server-5.6 mysql-client-5.6 wget unzip build-essential libssl-dev libffi-dev
	sed -i "s|bind-address.*|# bind-address = 127.0.0.1|" /etc/mysql/my.cnf
	mysql_install_db --user=onap --datadir=/var/lib/mysql
	chown -R onap:onap /usr/include/mysql
	chown -R onap:onap /usr/share/mysql
	chown -R onap:onap /usr/lib/perl5/auto/DBD/mysql
	chown -R onap:onap /usr/lib/perl5/DBD/mysql
	chown -R onap:onap /usr/bin/mysql
	chown -R onap:onap /var/lib/mysql
	chown -R onap:onap /var/log/mysql
	chown -R onap:onap /etc/init.d/mysql
	chown -R onap:onap /etc/mysql
	chown -R onap:onap /var/run/mysqld/

}

clean_sf_cache(){

        apt-get clean
        apt-get autoclean
        apt-get autoremove
}

add_user
install_sf
wait
clean_sf_cache
