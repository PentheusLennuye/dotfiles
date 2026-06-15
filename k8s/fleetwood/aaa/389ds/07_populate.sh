#!/usr/bin/env bash
# Configure 389 Directory Rervice my way

echo "Populating"

password=$(kubectl -n it get secret ds-dm-password -o json \
    | jq -r .data.password | base64 -d)

ldapadd -x -ZZ \
    -H ldap://ldap.cummings-online.local \
    -D cn="Directory Manager" \
    -w "${password}" \
    -f populate/populate.ldif
