#!/bin/bash

docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p "${DOCKER_PASS}"
for name in `docker ps -f status=running | grep latest | awk -F '  +' '{name=$7; sub(/_[0-9]+$/, "", name); print name}'`; do
    SHA=${CIRCLE_SHA1:0:7}
    IMG=${CIRCLE_PROJECT_USERNAME}/$name:$SHA

    docker tag $name:latest $IMG && docker push $IMG
done
