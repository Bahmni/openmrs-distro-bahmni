#!/bin/bash
set -xe

# Build Artifacts copied by CI to package/resources
# distro-${BAHMNI_VERSION}-SNAPSHOT.zip
# default_config.zip 

# Packaging default config to embed into default image
cp default_config.zip package/resources

# Downloading Atomfeed Client Jar &  Liquibase Core Jar
ATOMFEED_CLIENT_VERSION=${ATOMFEED_CLIENT_VERSION:-1.9.4}
LIQUIBASE_VERSION=${LIQUIBASE_VERSION:-2.0.5}

# Downloading atomfeed client and liquibase core
curl -L -o package/resources/atomfeed-client-${ATOMFEED_CLIENT_VERSION}.jar "https://oss.sonatype.org/content/repositories/releases/org/ict4h/atomfeed-client/${ATOMFEED_CLIENT_VERSION}/atomfeed-client-${ATOMFEED_CLIENT_VERSION}.jar"
curl -L -o package/resources/liquibase-core-${LIQUIBASE_VERSION}.jar "https://oss.sonatype.org/content/repositories/releases/org/liquibase/liquibase-core/${LIQUIBASE_VERSION}/liquibase-core-${LIQUIBASE_VERSION}.jar"


#Create build directory
mkdir build

# Unzipping Bahmni OMODs
unzip -q -u -j -d build/openmrs-modules package/resources/distro-${BAHMNI_VERSION}-SNAPSHOT-distro.zip

# Unzipping Default Config
unzip -q -u -d build/default_config package/resources/default_config.zip

# Building Docker images
OPENMRS_IMAGE_TAG=${BAHMNI_VERSION}-${GITHUB_RUN_NUMBER}
docker build -t bahmni/openmrs:${OPENMRS_IMAGE_TAG} -t bahmni/openmrs:latest -f package/docker/openmrs/Dockerfile  . --no-cache
