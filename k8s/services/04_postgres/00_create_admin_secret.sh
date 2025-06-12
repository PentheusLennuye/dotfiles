#/usr/bin/env bash

# Set up postgresql on kubernetes for general use

NS="cummings-online-local"

echo -n "Postgresql admin password: "
read -s admin_password
echo
echo -n "Confirm postgresql admin password: "
read -s confirm_password
echo

if [[ "${admin_password}" != "${confirm_password}" ]]
then
    echo "passwords do not match"
    exit 1
fi

kubectl -n ${NS} create secret generic \
    postgres-admin-credentials \
    --from-literal=username=admin \
    --from-literal=password=${admin_password}
