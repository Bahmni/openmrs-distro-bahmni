openmrs-distro-bahmni
==================

Please add the settings.xml file present in .github/workflows/ in /.m2 repo and replace the USER_NAME and ACCESS_TOKEN and then proceed to build

`./mvnw clean deploy` command to create artifacts.

This command will attempt to upload & publish artifacts to https://bahmnirepo.thoughtworks.com (maven repository). You will need authorization to upload (your public key needs to be on the server). 
