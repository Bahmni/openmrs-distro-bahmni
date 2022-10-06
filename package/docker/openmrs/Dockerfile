FROM openmrs/openmrs-distro-platform:2.5.7

ENV ATOMFEED_CLIENT_VERSION=1.10.1
ENV LIQUIBASE_VERSION=4.4.3
ENV LOGBACK_CORE_VERSION=1.2.3
ENV SLF4J_API_VERSION=1.7.28
ENV JMX_PROMETHEUS_JAVAAGENT_VERSION=0.17.2
# Creating Config Directories
RUN mkdir -p /usr/local/tomcat/.OpenMRS/modules/
RUN mkdir -p /tmp/artifacts/default_config/

# Downloading atomfeed client and liquibase core
RUN curl -L -o /tmp/artifacts/atomfeed-client-${ATOMFEED_CLIENT_VERSION}.jar "https://oss.sonatype.org/content/repositories/releases/org/ict4h/atomfeed-client/${ATOMFEED_CLIENT_VERSION}/atomfeed-client-${ATOMFEED_CLIENT_VERSION}.jar"
RUN curl -L -o /tmp/artifacts/liquibase-core-${LIQUIBASE_VERSION}.jar "https://oss.sonatype.org/content/repositories/releases/org/liquibase/liquibase-core/${LIQUIBASE_VERSION}/liquibase-core-${LIQUIBASE_VERSION}.jar"
RUN curl -L -o /tmp/artifacts/logback-core-${LOGBACK_CORE_VERSION}.jar "https://repo1.maven.org/maven2/ch/qos/logback/logback-core/${LOGBACK_CORE_VERSION}/logback-core-${LOGBACK_CORE_VERSION}.jar"
RUN curl -L -o /tmp/artifacts/slf4j-api-${SLF4J_API_VERSION}.jar "https://repo1.maven.org/maven2/org/slf4j/slf4j-api/${SLF4J_API_VERSION}/slf4j-api-${SLF4J_API_VERSION}.jar"
RUN curl -L -o /tmp/artifacts/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVAAGENT_VERSION}.jar "https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_PROMETHEUS_JAVAAGENT_VERSION}/jmx_prometheus_javaagent-${JMX_PROMETHEUS_JAVAAGENT_VERSION}.jar"

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

COPY package/docker/openmrs/setenv.sh /usr/local/tomcat/bin
COPY package/docker/openmrs/config.yml /usr/local/tomcat/bin
RUN chmod +x /usr/local/tomcat/bin/setenv.sh
RUN chmod +x /usr/local/tomcat/bin/config.yml

# Removing FHIR OMOD that comes bundled with OMRS base image
RUN unzip -o /usr/local/tomcat/webapps/openmrs.war -d /usr/local/tomcat/webapps/openmrs/
RUN cp /tmp/artifacts/jmx_prometheus_javaagent-*.jar /usr/local/tomcat/webapps/openmrs/WEB-INF/lib/jmx_prometheus_javaagent.jar
RUN rm -rf /tmp/artifacts
CMD ["./bahmni_startup.sh"]
