#!/bin/bash
set +e

run_sql() {
  mysql -N -s --host="${OMRS_DB_HOSTNAME}" --user="${OMRS_DB_USERNAME}" --password="${OMRS_DB_PASSWORD}" "${OMRS_DB_NAME}" -e "$1"
}

if [ $(run_sql "select count(*) from information_schema.tables where table_schema='${OMRS_DB_NAME}' and table_name='markers';") -gt 0 ]
then
    echo "Updating OpenELIS Host Port in markers and failed_events table"
    run_sql "update markers set feed_uri_for_last_read_entry = concat('http://${OPENELIS_HOST}:${OPENELIS_PORT}/openelis/ws/feed/patient',substring(feed_uri_for_last_read_entry, (LENGTH(feed_uri_for_last_read_entry) - LOCATE('/', REVERSE(feed_uri_for_last_read_entry)))+1) ) where feed_uri like '%openelis/ws/feed/patient/recent';"
    run_sql "update markers set feed_uri = 'http://${OPENELIS_HOST}:${OPENELIS_PORT}/openelis/ws/feed/patient/recent' where feed_uri like '%openelis/ws/feed/patient/recent';"
    run_sql "update failed_events set feed_uri = 'http://${OPENELIS_HOST}:${OPENELIS_PORT}/openelis/ws/feed/patient/recent' where feed_uri like '%openelis/ws/feed/patient/recent';"
fi
