FROM openmrs/openmrs-core:2.5.12

ENV JMX_PROMETHEUS_JAVAAGENT_VERSION=0.18.0
ENV OPENMRS_APPLICATION_DATA_DIRECTORY=/openmrs/data
ENV OMRS_DB_EXTRA_ARGS="&zeroDateTimeBehavior=convertToNull"

USER root

# Creating Config Directories
RUN mkdir -p /tmp/artifacts/
RUN mkdir -p /etc/jvm_metrics/

# Download JMX Prometheus Java agent
RUN curl -L -o /tmp/artifacts/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVAAGENT_VERSION}.jar "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_PROMETHEUS_JAVAAGENT_VERSION}/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVAAGENT_VERSION}.jar"

# Copy omods to OpenMRS Application Data Directory
COPY distro/target/distro/addresshierarchy-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/appframework-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/appointments-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/auditlog-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/bacteriology-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/bahmni-commons-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/bahmni.ie.apps-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/bahmnicore-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/bedmanagement-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/calculation-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/emrapi-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/episodes-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/event*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/fhir2*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/htmlwidgets*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/idgen*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/initializer*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/legacyui*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/metadatamapping*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/metadatasharing*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/openconceptlab*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/openelis-atomfeed-client*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/openmrs-atomfeed*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/operationtheater*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/owa*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/pacsquery*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/providermanagement*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/reference-data*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/reporting*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/reportingrest*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/rulesengine*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/serialization.xstream*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/teleconsultation*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/uicommons*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/uiframework*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/uilibrary*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/webservices.rest-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/communication*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/fhir-ts-services-int-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules
COPY distro/target/distro/fhir-cdss-int-*.omod  ${OPENMRS_APPLICATION_DATA_DIRECTORY}/modules

# Copy Configuration Files
COPY package/docker/openmrs/templates/bahmnicore.properties.template /etc/bahmni-emr/templates/
COPY package/docker/openmrs/templates/openmrs-runtime.properties.template /etc/bahmni-emr/templates/
COPY package/docker/openmrs/templates/mail-config.properties.template /etc/bahmni-emr/templates/
COPY package/docker/openmrs/templates/appointment.properties.template /etc/bahmni-emr/templates/

# Setting Soft Links from bahmni_config (Moved from bahmni-web postinstall)
RUN ln -s /etc/bahmni_config/openmrs/obscalculator ${OPENMRS_APPLICATION_DATA_DIRECTORY}/obscalculator
RUN ln -s /etc/bahmni_config/openmrs/ordertemplates ${OPENMRS_APPLICATION_DATA_DIRECTORY}/ordertemplates
RUN ln -s /etc/bahmni_config/openmrs/encounterModifier ${OPENMRS_APPLICATION_DATA_DIRECTORY}/encounterModifier
RUN ln -s /etc/bahmni_config/openmrs/patientMatchingAlgorithm ${OPENMRS_APPLICATION_DATA_DIRECTORY}/patientMatchingAlgorithm
RUN ln -s /etc/bahmni_config/openmrs/elisFeedInterceptor ${OPENMRS_APPLICATION_DATA_DIRECTORY}/elisFeedInterceptor
RUN ln -s /etc/bahmni_config ${OPENMRS_APPLICATION_DATA_DIRECTORY}/bahmni_config

# Creating Upload Directories
RUN mkdir -p /home/bahmni/patient_images
RUN mkdir -p /home/bahmni/document_images
RUN mkdir -p /home/bahmni/uploaded_results
RUN mkdir -p /home/bahmni/uploaded-files
COPY package/resources/blank-user.png /etc/bahmni/

# Used by envsubst command for replacing environment values at runtime
RUN yum install -y \
    mysql \
    mysql-client \
    gettext-base \
    gettext \
    acl

# Modify file permissions for document_images directory
RUN setfacl -d -m o::rx -m g::rx /home/bahmni/document_images/

COPY package/docker/openmrs/bahmni_startup.sh /openmrs/
RUN chmod +x /openmrs/bahmni_startup.sh

COPY package/docker/openmrs/update_elis_host_port.sh /openmrs/
RUN chmod +x /openmrs/update_elis_host_port.sh

RUN cp /tmp/artifacts/jmx_prometheus_javaagent-*.jar /etc/jvm_metrics/jmx_prometheus_javaagent.jar
COPY package/docker/openmrs/config.yml /etc/jvm_metrics/
RUN chmod +x /etc/jvm_metrics/config.yml

# Modify Startup Script to add Hibernate Properties
COPY package/resources/add_hibernate_properties.sh add_hibernate_properties.sh
RUN chmod +x add_hibernate_properties.sh 
RUN ./add_hibernate_properties.sh
RUN rm -rf add_hibernate_properties.sh

COPY package/resources/fhir-export-anonymise-config.json ${OPENMRS_APPLICATION_DATA_DIRECTORY}

RUN rm -rf /tmp/artifacts

CMD ["./bahmni_startup.sh"]
