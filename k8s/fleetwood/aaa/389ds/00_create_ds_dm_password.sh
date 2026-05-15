#!/usr/bin/env bash

NS=it
MYPASSWORD=

while [[ -z "$MYPASSWORD" ]]; do
    read -s -p "Directory Manager password: " prompt1
    echo
    read -s -p "Re-enter Directory Manager password: " prompt2
    echo

    if [[ "$prompt1" == "$prompt2" ]]; then
        MYPASSWORD=${prompt1}
    else
        echo "Passwords do not match."
        echo
    fi
done


kubectl create secret generic ds-dm-password \
    --namespace=${NS} \
    --from-literal=password=${MYPASSWORD}

