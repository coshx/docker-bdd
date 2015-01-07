#!/bin/bash

docker login -e $DOCKER_EMAIL -u $DOCKER_USER -p "${DOCKER_PASS}"
for name in `docker ps -f status=running | awk -F '  +' '{name=$7; sub(/_[0-9]+$/, "", name); print name}'`; do
    SHA=${CIRCLE_SHA1:0:7}
    IMG=${CIRCLE_PROJECT_USERNAME}/$name:$SHA

    docker tag $name:latest $IMG && docker push $IMG || echo "Failed to push $name - do you want to build this image and have a docker hub repository set up for it?" >&2
done
