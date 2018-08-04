#!/bin/bash

if [ -z "$SERVICE_IP" ]; then
    export SERVICE_IP=`hostname -i`
fi

if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    export MYSQL_ROOT_PASSWORD="root"
fi

date > init.log
echo "SERVICE_IP=$SERVICE_IP" >> init.log
echo "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" >> init.log

# Start the microservice
./instance_run.sh
