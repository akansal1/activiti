#!/usr/bin/env bash
# postgres-container-create.sh

VOLUME_DIR=$1

runContainer() {
	docker run --name my-activiti-postgres \
	-e POSTGRES_PASSWORD=myPostgres \
	-e POSTGRES_USER=postgres \
	-v ${VOLUME_DIR}:/var/lib/postgresql/data \
	--network=my-activiti-network \
	-p 15432:5432 \
	-d postgres:9.6.1-alpine	
}



if [ -z "$1" ]
	then
	echo "Must send in directory for volume mounting"
	exit -1
else 
	runContainer
fi





