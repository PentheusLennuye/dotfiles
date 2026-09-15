#!/usr/bin/env bash

NS=it
NOIP_USERNAME=
NOIP_PASSWORD=
NOIP_HOSTNAMES=

while [[ -z "$NOIP_USERNAME" ]]; do
    read -p "NoIP Username: " NOIP_USERNAME
done

while [[ -z "$NOIP_PASSWORD" ]]; do
    read -s -p "NoIP Password: " prompt1
    echo
    read -s -p "Re-enter NoIP Password: " prompt2
    echo
    if [[ "$prompt1" == "$prompt2" ]]; then
        NOIP_PASSWORD=${prompt1}
    else
        echo "Passwords do not match."
        echo
    fi
done

while [[ -z "$NOIP_HOSTNAMES" ]]; do
    read -p "NoIP Hostnames [comma-delimited]: " NOIP_HOSTNAMES
done


kubectl -n $NS create secret generic duc \
    --from-literal=noipUsername=${NOIP_USERNAME} \
    --from-literal=noipPassword=${NOIP_PASSWORD} \
    --from-literal=noipHostnames=${NOIP_HOSTNAMES}

