#!/bin/bash
set -e

# This script is used to run startup commands before starting OpenMRS distro startup script that comes with docker image. The last line starts OpenMRS script.
echo "Running Bahmnni EMR Startup Script..."

echo "Substituting Environment Variables..."
envsubst < /etc/bahmni-emr/templates/bahmnicore.properties.template > /usr/local/tomcat/.OpenMRS/bahmnicore.properties
envsubst < /etc/bahmni-emr/templates/openmrs-runtime.properties.template > /usr/local/tomcat/.OpenMRS/openmrs-runtime.properties
envsubst < /etc/bahmni-emr/templates/mail-config.properties.template > /usr/local/tomcat/.OpenMRS/mail-config.properties
/usr/local/tomcat/wait-for-it.sh --timeout=3600 ${DB_HOST}:3306

echo "Copy Configuration Folder from bahmni_config"
if [ -d /etc/bahmni_config/masterdata/configuration ]
then
  cp -r /etc/bahmni_config/masterdata/configuration/ /usr/local/tomcat/.OpenMRS/configuration/
fi
mysql --host="${DB_HOST}" --user="${DB_USERNAME}" --password="${DB_PASSWORD}" "${DB_DATABASE}" -e "UPDATE global_property SET global_property.property_value = '' WHERE  global_property.property = 'search.indexVersion';" || true

echo "Running OpenMRS Startup Script..."
./startup.sh
