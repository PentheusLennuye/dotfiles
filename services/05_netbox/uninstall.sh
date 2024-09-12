#!/usr/bin/env bash

# Uninstall Netbox from Cummings Online Local

NS="cummings-online-local"
RELEASE_NAME=netbox

delete_ingress () {
    kubectl delete -f ingress.yaml
}

delete_password () {
    kubectl -n ${NS} delete secret netbox-superuser-credentials
    kubectl -n ${NS} delete secret netbox-db-credentials
    kubectl -n ${NS} delete secret netbox-redis-credentials
}

helm_uninstall () {
    helm uninstall ${RELEASE_NAME} -n ${NS}
}

delete_ingress
helm_uninstall
delete_password

