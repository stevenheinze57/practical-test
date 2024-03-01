#!/bin/bash 

set -e 

docker build -t jenkins:local . 
docker run --rm -d --name jenkins -v "/var/run/docker.sock:/var/run/docker.sock:ro" -v "/Users/stevenhenze/.kube/config:/root/.kube/config" -p 8080:8080 jenkins:local

sleep 30 

admin_pass=$(docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword)
echo ""
echo "Admin password: $admin_pass"
echo "" 
