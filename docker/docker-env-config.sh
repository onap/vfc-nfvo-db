#!/bin/bash

add_user(){

        useradd onap
	      chown onap:onap -R /service
}

install_sf(){
	
	      apt-get update
        apt-get install -y redis-server
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
