#!/bin/bash 

set -e 

# Build Variables 
BTC_VERSION=22.0

# Grype Variables 
export GRYPE_DB_CACHE_DIR=./grype_cache 

# TODO: Check if already running....  
# open -a /Applications/Docker.app
# sleep 10 

docker build --build-arg "BTC_VERSION=${BTC_VERSION}" -t bitcoin:${BTC_VERSION} -f Dockerfile . 

# Run anchore testing 
syft bitcoin:${BTC_VERSION}
grype bitcoin:${BTC_VERSION}

docker run --rm -it -v "bitcoin:/root/.bitcoin" -p 8333:8333 -p 8332:8332 bitcoin:${BTC_VERSION}
