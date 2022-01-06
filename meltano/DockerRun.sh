#!/bin/bash

# Settings
DOCKER_IMAGE="meltano/meltano:latest"
PROJECT_NAME=${PROJECT_NAME}
# VOLUME=${VOLUME}
# HTTPS_PORT=${HTTPS_PORT}
# CONTAINER_HOSTNAME=${CONTAINER_HOSTNAME}
# SOCKET_PORT=${SOCKET_PORT:-10001}
# KEYSTORE_PASSWORD=${KEYSTORE_PASSWORD}
# TRUSTSTORE_PASSWORD=${TRUSTSTORE_PASSWORD}
# DNS=${DNS}
# HOST_CERTIFICATES_DIRECTORY="/home/certificates"

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
        -p 8080:5000 \
        -v $(pwd):/projects \
        -w /projects \
        $DOCKER_IMAGE ui
