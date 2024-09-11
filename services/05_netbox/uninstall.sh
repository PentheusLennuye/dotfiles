#!/usr/bin/env bash

# Uninstall Netbox from Cummings Online Local

NS="cummings-online-local"
RELEASE_NAME=netbox

delete_password () {
    kubectl -n ${NS} delete secret netbox-superuser-credentials
}

helm_uninstall () {
    helm uninstall ${RELEASE_NAME} -n ${NS}
}

delete_ingress() {
    kubectl -n ${NS} delete ingress ${RELEASE_NAME}
}


delete_ingress
helm_uninstall
delete_password

