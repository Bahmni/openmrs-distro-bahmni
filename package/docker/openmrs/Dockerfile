FROM openmrs/openmrs-distro-platform:2.4.2

ENV ATOMFEED_CLIENT_VERSION=1.10.1
ENV LIQUIBASE_VERSION=3.10.2

# Creating Config Directories
RUN mkdir -p /usr/local/tomcat/.OpenMRS/modules/
RUN mkdir -p /tmp/artifacts/default_config/
RUN mkdir -p /tmp/artifacts/distro/
RUN mkdir -p /etc/bahmni-lab-connect/

# Downloading atomfeed client and liquibase core
RUN curl -L -o /tmp/artifacts/atomfeed-client-${ATOMFEED_CLIENT_VERSION}.jar "https://oss.sonatype.org/content/repositories/releases/org/ict4h/atomfeed-client/${ATOMFEED_CLIENT_VERSION}/atomfeed-client-${ATOMFEED_CLIENT_VERSION}.jar"
RUN curl -L -o /tmp/artifacts/liquibase-core-${LIQUIBASE_VERSION}.jar "https://oss.sonatype.org/content/repositories/releases/org/liquibase/liquibase-core/${LIQUIBASE_VERSION}/liquibase-core-${LIQUIBASE_VERSION}.jar"

#unzip default_config
ADD package/resources/default_config.zip /tmp/artifacts/
RUN unzip -d /tmp/artifacts/default_config/ /tmp/artifacts/default_config.zip

COPY distro/target/distro/*.omod /usr/local/tomcat/.OpenMRS/modules/
COPY package/docker/openmrs/templates/bahmnicore.properties.template /etc/bahmni-emr/templates/
COPY package/docker/openmrs/templates/openmrs-runtime.properties.template /etc/bahmni-emr/templates/

# Add the latest ot, fhir and web-services modules with OMRS:2.4.2 changes
RUN rm /usr/local/tomcat/.OpenMRS/modules/operationtheater*.omod
RUN rm /usr/local/tomcat/.OpenMRS/modules/webservices.rest*.omod
RUN rm /usr/local/tomcat/.OpenMRS/modules/fhir2*.omod
COPY package/docker/openmrs/resources/*.omod /usr/local/tomcat/.OpenMRS/modules/

RUN cp /tmp/artifacts/atomfeed-client-*.jar /etc/bahmni-lab-connect/atomfeed-client.jar
RUN cp /tmp/artifacts/liquibase-core-*.jar /etc/bahmni-lab-connect/liquibase-core.jar
RUN cp -r /tmp/artifacts/default_config/. /etc/bahmni_config/

# Setting Soft Links from bahmni_config (Moved from bahmni-web postinstall)
RUN ln -s /etc/bahmni_config/openmrs/obscalculator /usr/local/tomcat/.OpenMRS/obscalculator
RUN ln -s /etc/bahmni_config/openmrs/ordertemplates /usr/local/tomcat/.OpenMRS/ordertemplates
RUN ln -s /etc/bahmni_config/openmrs/encounterModifier /usr/local/tomcat/.OpenMRS/encounterModifier
RUN ln -s /etc/bahmni_config/openmrs/patientMatchingAlgorithm /usr/local/tomcat/.OpenMRS/patientMatchingAlgorithm
RUN ln -s /etc/bahmni_config/openmrs/elisFeedInterceptor /usr/local/tomcat/.OpenMRS/elisFeedInterceptor
RUN ln -s /etc/bahmni_config /usr/local/tomcat/.OpenMRS/bahmni_config

# Creating Upload Directories
RUN mkdir -p /home/bahmni/patient_images
RUN mkdir -p /home/bahmni/document_images
COPY package/resources/blank-user.png /etc/bahmni/

# Used by envsubst command for replacing environment values at runtime
RUN apt-get update && apt-get install gettext-base mysql-client -y

COPY package/docker/openmrs/bahmni_startup.sh /usr/local/tomcat/
RUN chmod +x /usr/local/tomcat/bahmni_startup.sh

# Removing FHIR OMOD that comes bundled with OMRS base image
RUN unzip -o /usr/local/tomcat/webapps/openmrs.war -d /usr/local/tomcat/webapps/openmrs/
RUN rm -rf /tmp/artifacts
CMD ["./bahmni_startup.sh"]
