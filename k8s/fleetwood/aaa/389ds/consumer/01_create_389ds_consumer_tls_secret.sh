#!/usr/bin/env bash
# 
# Create the secret with ca chain, cert, key and dh param
# This does NOT use the secret tls, but rather generic as ca chain and dh
# params need to be separated for bitnomi LDAP.
# 
# The ca bundle must have the name <FQDN>-chain.crt
# The cert and key must have the name <HOSTNAME>.<FQDN>.(crt|key)
# The dh parameter file must have the name <HOSTNAME>.<FQDN>-dhparam.pem

HOSTNAME=$1
DOMAIN=$2

while [[ -z "$DOMAIN" ]]; do
    read -p "Service hostname: " HOSTNAME
    read -p "Domain name: " DOMAIN
done

STORE=$HOME/Documents/spaces/tech/infra/ca/${DOMAIN}/store
KEYFILE=${STORE}/${HOSTNAME}.${DOMAIN}.key
CERTFILE=${STORE}/${HOSTNAME}.${DOMAIN}-bundle.crt
CACERTFILE=${STORE}/../../certs/ca.cummings-online.crt

for f in $KEYFILE $CERTFILE $CACERTFILE; do
    if [ ! -f $f ]; then
        echo
        echo "$f missing. Exiting."
        echo
        exit 1
    fi
done

kubectl create secret generic 389ds-consumer-tls \
    --from-file=server.key=${KEYFILE} --from-file=server.crt=${CERTFILE} \
    --from-file="ca.crt"=${CACERTFILE}

