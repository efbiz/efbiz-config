#!/bin/sh

# apollo config db info
apollo_config_db_url=jdbc:mysql://rds0ody743j45rhlm2pb.mysql.rds.aliyuncs.com:3306/efbizconfig?characterEncoding=utf8
apollo_config_db_username=config
apollo_config_db_password=configAdmin520

# apollo portal db info
apollo_portal_db_url=jdbc:mysql://rds0ody743j45rhlm2pb.mysql.rds.aliyuncs.com:3306/efbizconfigportal?characterEncoding=utf8
apollo_portal_db_username=config
apollo_portal_db_password=configAdmin520

# meta server url
dev_meta=http://localhost:8888
fat_meta=http://localhost:8888
uat_meta=http://localhost:8888
pro_meta=http://localhost:8888

META_SERVERS_OPTS="-Ddev_meta=$dev_meta -Dfat_meta=$fat_meta -Duat_meta=$uat_meta -Dpro_meta=$pro_meta"

# =============== Please do not modify the following content =============== #
cd ..

# package config-service and admin-service
echo "==== starting to build config-service and admin-service ===="

mvn clean package -DskipTests -pl config-service,config-admin -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_config_db_url -Dspring_datasource_username=$apollo_config_db_username -Dspring_datasource_password=$apollo_config_db_password

echo "==== building config-service and admin-service finished ===="

echo "==== starting to build portal ===="

mvn clean package -DskipTests -pl config-portal -am -Dapollo_profile=github -Dspring_datasource_url=$apollo_portal_db_url -Dspring_datasource_username=$apollo_portal_db_username -Dspring_datasource_password=$apollo_portal_db_password $META_SERVERS_OPTS

echo "==== building portal finished ===="

echo "==== starting to build client ===="

mvn clean install -DskipTests -pl config-client -am $META_SERVERS_OPTS

echo "==== building client finished ===="

