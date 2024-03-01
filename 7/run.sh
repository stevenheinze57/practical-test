#!/bin/bash 

set -e 

# Local nomad agent should be running prior to this script (nomad agent -dev)
# TODO: Add steps to start the process in the background and cleanup after 

NOMAD_ADDR="http://localhost:4646"
# NOMAD_REGION=ue1
# NOMAD_NAMESPACE=dev

nomad job validate -address=$NOMAD_ADDR -var name=bitcoin -var-file=dev.vars nomad.hcl

nomad job run -address=$NOMAD_ADDR -var name=bitcoin -var-file=dev.vars nomad.hcl
