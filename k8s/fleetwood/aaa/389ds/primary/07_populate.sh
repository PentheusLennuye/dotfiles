#!/usr/bin/env bash
# Configure 389 Directory Service my way

echo "Populating"

password=$(kubectl -n it get secret ds-dm-password -o json \
    | jq -r .data.password | base64 -d)

ldapadd -x -ZZ \
    -H ldap://ldap.cummings-online.ca \
    -D cn="Directory Manager" \
    -w "${password}" \
    -f populate/populate.ldif

echo "Setting ACI's"

ldapmodify -x -ZZ \
    -H ldap://ldap.cummings-online.ca \
    -D cn="Directory Manager" \
    -w "${password}" \
    -f populate/aci.ldif
