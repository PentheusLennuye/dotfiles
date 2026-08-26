#!/usr/bin/env bash
# 
# Create the secret with ca chain, cert, key and dh param
# This does NOT use the secret tls, but rather generic as ca chain and dh
# params need to be separated for bitnomi LDAP.
# 
# The ca bundle must have the name <FQDN>-chain.crt
# The cert and key must have the name <HOSTNAME>.<FQDN>.(crt|key)
# The dh parameter file must have the name <HOSTNAME>.<FQDN>-dhparam.pem

source ./vars
source ./env

while [[ -z "$STORE" ]]; do
    read -p "Service hostname: " HOSTNAME
    read -p "Domain name: " DOMAIN
    read -p "Certificate store path: " STORE
done

KEYFILE=${STORE}/${HOSTNAME}.${DOMAIN}.key
CERTFILE=${STORE}/${HOSTNAME}.${DOMAIN}.crt
CACERTFILE=${STORE}/${DOMAIN}-chain.crt

for f in $KEYFILE $CERTFILE $CACERTFILE $DHFILE; do
    if [ ! -f $f ]; then
        echo
        echo "$f missing. Exiting."
        echo
        exit 1
    fi
done

kubectl create secret generic $SECRET_NAME \
    --from-file=server.key=${KEYFILE} --from-file=server.crt=${CERTFILE} \
    --from-file="ca.crt"=${CACERTFILE}

