#!/bin/bash

# Settings
DOCKER_IMAGE="meltano/meltano:latest"
PROJECT_NAME=${PROJECT_NAME}

docker run \
    -v $(pwd):/projects \
    -w /projects \
    $DOCKER_IMAGE init $PROJECT_NAME

cd $PROJECT_NAME && docker run \
                            -v $(pwd):/projects \
                            -w /projects \
                            $DOCKER_IMAGE add extractor tap-mongodb

docker run \
        -v $(pwd):/projects \
        -w /projects \
        $DOCKER_IMAGE add loader target-postgres

docker run \
        --rm \
        --network=mongo-postres-sync \
        -p 8086:5000 \
        -v $(pwd):/projects \
        -w /projects \
        $DOCKER_IMAGE --log-level=debug ui

# enables you select the entities to focus on
# docker run -v $(pwd):/projects -w /projects meltano/meltano:latest select tap-mongodb --list --all

# set replication method for all entities
# docker run -v $(pwd):/projects -w /projects meltano/meltano:latest config tap-mongodb set _metadata '*' replication-method LOG_BASED

# set replication method key
# docker run -v $(pwd):/projects -w /projects meltano/meltano:latest config tap-mongodb set _metadata '*' replication-key id

# verify stream metadata
# docker run -v $(pwd):/projects -w /projects meltano/meltano:latest invoke --dump=catalog tap-mongodb

# run el pipeline
# docker run -v $(pwd):/projects -w /projects meltano/meltano:latest elt tap-mongodb target-postgres --job_id=mongodb-to-postgres