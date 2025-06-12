#/usr/bin/env bash

# Set up redis on kubernetes for general use

NS="cummings-online-local"

echo -n "Redis admin password: "
read -s admin_password
echo
echo -n "Confirm redis admin password: "
read -s confirm_password
echo

if [[ "${admin_password}" != "${confirm_password}" ]]
then
    echo "passwords do not match"
    exit 1
fi

kubectl -n ${NS} create secret generic \
    redis-admin-credentials \
    --from-literal=username=default \
    --from-literal=password=${admin_password}
