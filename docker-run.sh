#!/usr/bin/env bash
# docker-run.sh
docker rm $(docker stop my_activiti)
docker run --name=my_activiti --detach \
	-p 10020:8080 \
	--network=my-activiti-network \
	-e 'DB_HOST=my-activiti-postgres' \
	-e 'DB_PORT=5432' \
	-e 'DB_NAME=my_activiti_db' \
	-e 'DB_USER=activiti' \
	-e 'DB_PASS=apassword' \
	kentoj/activiti:latest