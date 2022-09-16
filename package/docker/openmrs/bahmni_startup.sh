#!/bin/bash
set -e

# This script is used to run startup commands before starting OpenMRS distro startup script that comes with docker image. The last line starts OpenMRS script.
echo "Running Bahmnni EMR Startup Script..."

# JAR_DIR="/etc/bahmni-lab-connect"
# LIQUIBASE_JAR="$JAR_DIR/liquibase-core.jar"
# ATOMFEED_CLIENT_JAR="$JAR_DIR/atomfeed-client.jar"
# LOGBACK_CORE_JAR="$JAR_DIR/logback-core.jar"
# SLF4J_API_JAR="$JAR_DIR/slf4j-api.jar"

# CHANGE_LOG_TABLE="-Dliquibase.databaseChangeLogTableName=liquibasechangelog -Dliquibase.databaseChangeLogLockTableName=liquibasechangeloglock -DschemaName=${DB_DATABASE}"
# DRIVER="com.mysql.cj.jdbc.Driver"
# URL="jdbc:mysql://$DB_HOST:3306/${DB_DATABASE} --username=$DB_USERNAME --password=$DB_PASSWORD"
# CLASS_PATH="$LIQUIBASE_JAR:$ATOMFEED_CLIENT_JAR:/usr/local/tomcat/webapps/openmrs.war:$LOGBACK_CORE_JAR:$SLF4J_API_JAR"

echo "Substituting Environment Variables..."
envsubst < /etc/bahmni-emr/templates/bahmnicore.properties.template > /usr/local/tomcat/.OpenMRS/bahmnicore.properties
envsubst < /etc/bahmni-emr/templates/openmrs-runtime.properties.template > /usr/local/tomcat/.OpenMRS/openmrs-runtime.properties
/usr/local/tomcat/wait-for-it.sh --timeout=3600 ${DB_HOST}:3306

# Running Atomfeed Migrations
# java $CHANGE_LOG_TABLE -cp $CLASS_PATH liquibase.integration.commandline.Main --driver=$DRIVER --url=$URL --username=$DB_USERNAME --password=$DB_PASSWORD --classpath=$ATOMFEED_CLIENT_JAR:/usr/local/tomcat/webapps/openmrs.war --changeLogFile=sql/db_migrations.xml update

#Copying OMODS from bahmni_config
configOMODCount=$(ls -1 /etc/bahmni_config/openmrs/omods/*.omod 2>/dev/null | wc -l)
if [ "$configOMODCount" -gt 0 ]
then
  cp /etc/bahmni_config/openmrs/omods/*.omod /usr/local/tomcat/.OpenMRS/modules/
fi

#Copy Configuration Folder for Initializer OMOD
if [ -d /etc/bahmni_config/masterdata/configuration ]
then
  cp -r /etc/bahmni_config/masterdata/configuration /usr/local/tomcat/.OpenMRS/
fi

mysql --host="${DB_HOST}" --user="${DB_USERNAME}" --password="${DB_PASSWORD}" "${DB_DATABASE}" -e "UPDATE global_property SET global_property.property_value = '' WHERE  global_property.property = 'search.indexVersion';" || true

echo "Running OpenMRS Startup Script..."
./startup.sh
