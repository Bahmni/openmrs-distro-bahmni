#!/bin/bash
set -xe

# Building Docker images
OPENMRS_IMAGE_TAG=${BAHMNI_VERSION}-${GITHUB_RUN_NUMBER}
docker build -t bahmni/openmrs-db:fresh-${OPENMRS_IMAGE_TAG} -t bahmni/openmrs-db:fresh-latest -f package/docker/freshDB/Dockerfile  . --no-cache
