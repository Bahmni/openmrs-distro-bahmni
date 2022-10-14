FROM openmrs/openmrs-distro-platform:2.5.7

# Creating Config Directories
RUN mkdir -p /usr/local/tomcat/.OpenMRS/modules/
RUN mkdir -p /tmp/artifacts/default_config/

#unzip default_config
ADD package/resources/default_config.zip /tmp/artifacts/
RUN unzip -d /tmp/artifacts/default_config/ /tmp/artifacts/default_config.zip

COPY distro/target/distro/*.omod /usr/local/tomcat/.OpenMRS/modules/
COPY package/docker/openmrs/templates/bahmnicore.properties.template /etc/bahmni-emr/templates/
COPY package/docker/openmrs/templates/openmrs-runtime.properties.template /etc/bahmni-emr/templates/

# Add the latest ot and web-services modules with OMRS:2.4.2 changes
RUN rm /usr/local/tomcat/.OpenMRS/modules/operationtheater*.omod
RUN rm /usr/local/tomcat/.OpenMRS/modules/webservices.rest*.omod
COPY package/docker/openmrs/resources/*.omod /usr/local/tomcat/.OpenMRS/modules/

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
RUN rm -rf /tmp/artifacts
CMD ["./bahmni_startup.sh"]
