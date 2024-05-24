#!/bin/bash
set -e

# This script is used to run startup commands before starting OpenMRS distro startup script that comes with docker image. The last line starts OpenMRS script.
echo "Running Bahmnni EMR Startup Script..."

echo "Substituting Environment Variables..."
envsubst < /etc/bahmni-emr/templates/bahmnicore.properties.template > ${OPENMRS_APPLICATION_DATA_DIRECTORY}/bahmnicore.properties
envsubst < /etc/bahmni-emr/templates/openmrs-runtime.properties.template > ${OPENMRS_APPLICATION_DATA_DIRECTORY}/openmrs-runtime.properties
envsubst < /etc/bahmni-emr/templates/mail-config.properties.template > ${OPENMRS_APPLICATION_DATA_DIRECTORY}/mail-config.properties
envsubst < /etc/bahmni-emr/templates/appointment.properties.template > ${OPENMRS_APPLICATION_DATA_DIRECTORY}/appointment.properties
envsubst < /etc/bahmni-emr/templates/rulesengine-concept.properties.template > ${OPENMRS_APPLICATION_DATA_DIRECTORY}/rulesengine-concept.properties
/openmrs/wait-for-it.sh --timeout=3600 ${OMRS_DB_HOSTNAME}:3306

echo "Copy Configuration Folder from bahmni_config"
if [ -d /etc/bahmni_config/masterdata/configuration ]
then
  cp -r /etc/bahmni_config/masterdata/configuration/ ${OPENMRS_APPLICATION_DATA_DIRECTORY}/
fi
mysql --host="${OMRS_DB_HOSTNAME}" --user="${OMRS_DB_USERNAME}" --password="${OMRS_DB_PASSWORD}" "${OMRS_DB_NAME}" -e "UPDATE global_property SET global_property.property_value = '' WHERE  global_property.property = 'search.indexVersion';" || true

./update_elis_host_port.sh

if [ "${OMRS_DOCKER_ENV}" = 'true' ]
then
echo "setting the folder permissions"
setfacl -R -d -m o::rx -m g::rx /home/bahmni/document_images
setfacl -R -d -m o::rx -m g::rx /home/bahmni/uploaded_results
setfacl -R -d -m o::rx -m g::rx /home/bahmni/uploaded-files
fi

echo "Running OpenMRS Startup Script..."
./startup.sh
