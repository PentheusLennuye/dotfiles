#!/usr/bin/env bash

DOMAIN="cummings-online.local"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)

dn="cn=${ADMIN},o=Cummings Online"
add="ldapadd -x -ZZ -H ldap://ldap.${DOMAIN}"

$add -D "${dn}" -w "${PASSWORD}" -f data/populate.ldif

