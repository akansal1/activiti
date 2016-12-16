#!/usr/bin/env bash
# docker-run-test.sh
docker run --name=my_activiti_test -it --rm \
	-p 10021:8080 \
	--network=my-activiti-network \
	-e 'DB_HOST=my-activiti-postgres' \
	-e 'DB_PORT=5432' \
	-e 'DB_NAME=my_activiti_db' \
	-e 'DB_USER=activiti' \
	-e 'DB_PASS=apassword' \
	kentoj/activiti:latest 