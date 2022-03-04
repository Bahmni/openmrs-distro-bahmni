FROM mysql:5.6

ADD https://github.com/Bahmni/bahmni-scripts/blob/master/demo/db-backups/v0.92/openmrs_backup.sql.gz\?raw\=true /resources/
RUN gunzip /resources/openmrs_backup.sql.gz && chmod +rx /resources/*.sql && rm -f /resources/openmrs_backup.sql.gz
RUN cp /resources/openmrs_backup.sql /docker-entrypoint-initdb.d/
