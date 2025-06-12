#!/usr/bin/env bash

MYPASSWORD=

while [[ -z "$MYPASSWORD" ]]; do
    read -s -p "LDAP admin password: " prompt1
    echo
    read -s -p "Re-enter LDAP admin password: " prompt2
    echo

    if [[ "$prompt1" == "$prompt2" ]]; then
        MYPASSWORD=${prompt1}
    else
        echo "Passwords do not match."
        echo
    fi
done


kubectl create secret generic ldap-admin \
    --from-literal=password=${MYPASSWORD} \
    --from-literal=username=admin

