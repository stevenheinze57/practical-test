#!/bin/bash 

set -e 

terraform init 
terraform validate 

# skipping plan 
terraform apply 

terraform destroy 
