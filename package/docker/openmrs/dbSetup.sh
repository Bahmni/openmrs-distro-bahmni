#!/bin/bash
set -e

echo "Starting DB Setup"
DBEXISTS=$(mysql --host="${DB_HOST}" --user="${DB_ROOT_USERNAME}" --password="${DB_ROOT_PASSWORD}" --skip-column-names -e "SHOW DATABASES LIKE '${DB_DATABASE}'")
if [ "${DBEXISTS}" == "${DB_DATABASE}" ]; then
    echo "Database ${DB_DATABASE} exists. Skipping Database population "
    exit 0
fi
echo "Creating Database ${DB_DATABASE}.."
mysql --host="${DB_HOST}" --user="${DB_ROOT_USERNAME}" --password="${DB_ROOT_PASSWORD}" -e "CREATE DATABASE ${DB_DATABASE};"
mysql --host="${DB_HOST}" --user="${DB_ROOT_USERNAME}" --password="${DB_ROOT_PASSWORD}" -e "CREATE USER '${DB_USERNAME}' IDENTIFIED BY '${DB_PASSWORD}';"
mysql --host="${DB_HOST}" --user="${DB_ROOT_USERNAME}" --password="${DB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON ${DB_DATABASE}. * TO '${DB_USERNAME}';"

echo "Populating Data into Database.."
if [ "${LOAD_DEMO_DATA}" == "true"  ]
then
  echo "Loading Demo Dump Data..."
  curl -L -o openmrs.sql.gz "${DB_DUMP_GZIP_URL:-"https://github.com/Bahmni/bahmni-scripts/blob/master/demo/db-backups/v0.92/openmrs_backup.sql.gz\?raw\=true"}"
  gunzip openmrs.sql.gz
else
  echo "Loading Clean Dump Data..."
  curl -L -o openmrs.sql 'https://raw.githubusercontent.com/Bahmni/openmrs-distro-bahmni/master/package/docker/freshDB/openmrs_clean_dump.sql'
fi
mysql --force --host="${DB_HOST}" --user="${DB_USERNAME}" --password="${DB_PASSWORD}" "${DB_DATABASE}" < openmrs.sql
echo "DB Setup Done"
