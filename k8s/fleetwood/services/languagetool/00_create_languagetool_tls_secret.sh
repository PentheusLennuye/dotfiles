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
STORE=$3

while [[ -z "$STORE" ]]; do
    read -p "Service hostname: " HOSTNAME
    read -p "Domain name: " DOMAIN
    read -p "Certificate store path: " STORE
done

KEYFILE=${STORE}/${HOSTNAME}.${DOMAIN}.key
CERTFILE=${STORE}/${HOSTNAME}.${DOMAIN}-bundle.crt

for f in $KEYFILE $CACERTFILE; do
    echo "looking for ${f}"
    if [ ! -f $f ]; then
        echo
        echo "$f missing. Exiting."
        echo
        exit 1
    fi
done

kubectl create secret tls languagetool-tls \
    --namespace it --key=${KEYFILE} --cert=${CERTFILE}
    

