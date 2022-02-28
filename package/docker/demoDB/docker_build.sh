#!/bin/bash
set -xe

# Using Database Backup data from bahmni-scripts repo
gunzip -f -k bahmni-scripts/demo/db-backups/v0.92/openmrs_backup.sql.gz
cp bahmni-scripts/demo/db-backups/v0.92/openmrs_backup.sql package/resources/openmrs_demo_dump.sql

# Building Docker images
OPENMRS_IMAGE_TAG=${BAHMNI_VERSION}-${GITHUB_RUN_NUMBER}
docker build -t bahmni/openmrs-db:demo-${OPENMRS_IMAGE_TAG} -t bahmni/openmrs-db:demo-latest -f package/docker/demoDB/Dockerfile  . --no-cache
