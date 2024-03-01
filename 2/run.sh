#!/bin/bash 

set -e 

BTC_VERSION=22.0

echo "Starting minikube" 
eval $(minikube docker-env)
# TODO: This is failing locally in a fresh terminal env... not sure why yet... 
# (need to run minikube start prior to running this script)
minikube start 

echo "Building image"
# Rebuild container to be available within local minikube docker env 
cd ..
docker build --build-arg "BTC_VERSION=${BTC_VERSION}" -t bitcoin:${BTC_VERSION} -f ./1/Dockerfile . 
cd 2

# TODO: Create namespace 
# kubectl create namespace crypto 

echo "Deploying" 
kubectl apply -f deployment.yaml 
kubectl rollout status -w deployment/bitcoin 

minikube stop 
