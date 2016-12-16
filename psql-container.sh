#!/usr/bin/env bash
# psql-container.sh

docker run \
	--name my-activiti-postgres-psql \
	--network my-activiti-network \
	--link my-activiti-postgres:postgres \
	-it \
	--rm postgres:9.6.1-alpine \
	psql -h postgres -U postgres