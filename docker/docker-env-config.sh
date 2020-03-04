#!/bin/bash

install_sf(){

	sed -i "s|set compatible|set nocompatible|" /etc/vim/vimrc.tiny
	echo "set backspace=2" >> /etc/vim/vimrc.tiny

	echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
	echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
	
	apt-get update
        apt-get install -y gcc libmysqlclient-dev redis-server mysql-server-5.6 mysql-client-5.6 wget unzip build-essential libssl-dev libffi-dev
	sed -i "s|bind-address.*|# bind-address = 127.0.0.1|" /etc/mysql/my.cnf
}

add_user(){

        useradd onap
	chmod u+w /etc/sudoers
	sed -i '/User privilege specification/a\onap    ALL=(ALL:ALL) NOPASSWD:ALL' /etc/sudoers
	chmod u-w /etc/sudoers
	chown onap:onap -R /service

}

clean_sf_cache(){

        apt-get clean
        apt-get autoclean
        apt-get autoremove
}

install_sf
wait
add_user
clean_sf_cache
