openmrs-distro-bahmni
==================

In order to use the bahmnicore artifacts from github packages, please add the `settings.xml` file present in `.github/` in `/.m2` repo and replace the USER_NAME (Github username) and ACCESS_TOKEN (GitHub PAT) and then proceed to build

Else the artifacts by default would be downloaded from S3.

`./mvnw clean deploy` command to create artifacts.

This command will attempt to upload & publish artifacts to https://bahmnirepo.thoughtworks.com (maven repository). You will need authorization to upload (your public key needs to be on the server). 
