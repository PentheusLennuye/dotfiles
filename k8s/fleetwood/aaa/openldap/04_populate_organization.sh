#!/usr/bin/env bash

HOST="ldap.cummings-online.local"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)

dn="cn=${ADMIN},dc=cummings-online,dc=ca"
add="ldapadd -x -ZZ -H ldap://${HOST}"

$add -D "${dn}" -w "${PASSWORD}" -f data/populate.ldif

