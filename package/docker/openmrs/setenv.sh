export JAVA_OPTS="-Dfile.encoding=UTF-8 -server -Xms2048m -Xmx2048m -XX:NewSize=1024m -XX:MaxNewSize=1024m -XX:MetaspaceSize=768m -XX:MaxMetaspaceSize=768m -XX:InitialCodeCacheSize=64m -XX:ReservedCodeCacheSize=96m -XX:SurvivorRatio=16 -XX:TargetSurvivorRatio=50 -XX:MaxTenuringThreshold=15 -XX:+UseParNewGC -XX:ParallelGCThreads=16 -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+CMSCompactWhenClearAllSoftRefs -XX:CMSInitiatingOccupancyFraction=85 -XX:+CMSScavengeBeforeRemark -javaagent:/etc/jvm_metrics/jmx_prometheus_javaagent.jar=8280:/etc/jvm_metrics/config.yml -agentpath:/etc/jvm_profiling/YourKit-JavaProfiler-2022.9/bin/linux-x86-64/libyjpagent.so=port=10001,listen=all"
export CATALINA_OPTS="-DOPENMRS_INSTALLATION_SCRIPT=/usr/local/tomcat/openmrs-server.properties -DOPENMRS_APPLICATION_DATA_DIRECTORY=/usr/local/tomcat/.OpenMRS"