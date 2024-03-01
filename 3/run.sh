#!/bin/bash 

set -e 

eval $(minikube docker-env)
# TODO: This is failing locally in a fresh terminal env... not sure why yet... 
# (need to run minikube start prior to running this script)
minikube start

read "Press Enter to continue"

minikube stop 

# TODO: Automate the Jenkinsfile execution with JobDSL, CasC, etc... 
