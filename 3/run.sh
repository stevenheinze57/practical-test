#!/bin/bash 

set -e 

docker build -t jenkins:local . 
docker run --rm -d --name jenkins -p 8080:8080 jenkins:local

sleep 30 

admin_pass=$(docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword)
echo ""
echo "Admin password: $admin_pass"
echo ""

# TODO: Automate the Jenkinsfile execution with JobDSL, CasC, etc... 
