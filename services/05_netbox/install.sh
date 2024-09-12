#!/usr/bin/env bash

# Install Netbox into Cummings Online Local

NS="cummings-online-local"
RELEASE_NAME=netbox

create_superuser_pass() {
  echo -n "Superuser password: "
  read -s admin_password
  echo
  echo -n "Confirm superuser password: "
  read -s confirm_password
  echo

  echo -n "API token: "
  read api_token

  if [[ "${admin_password}" != "${confirm_password}" ]]
  then
    echo "passwords do not match"
    exit 1
  fi

    kubectl -n ${NS} create secret generic \
        netbox-superuser-credentials \
        --from-literal=username=admin \
        --from-literal=password=${admin_password} \
        --from-literal=email=admin@cummings-online.local \
        --from-literal=api_token=${api_token}
}

create_postgres_db() {
  echo -n "Postgres netbox db password: "
  read -s db_password
  echo
  echo -n "Confirm netbox db password: "
  read -s confirm_password
  echo

  if [[ "${db_password}" != "${confirm_password}" ]]
  then
    echo "passwords do not match"
    exit 1
  fi

    kubectl -n ${NS} create secret generic \
        netbox-db-credentials \
        --from-literal=username=netbox \
        --from-literal=postgresql-password=${db_password}

    POD=$(kubectl -n cummings-online-local get po \
          | grep postgres | awk '{print $1}')

    kubectl -n ${NS} exec -i ${POD} -- psql -d postgres -U postgres << EOF
CREATE ROLE netbox WITH LOGIN PASSWORD '${db_password}';
CREATE DATABASE netbox OWNER netbox;
EOF
}

create_redis_secret () {
    SECRET=$(kubectl -n ${NS} get secret redis-admin-credentials \
             -o=jsonpath='{.data.password}' \
            | base64 -d)

    kubectl -n ${NS} create secret generic netbox-redis-credentials \
        --from-literal=redis-password=${SECRET}
}


helm_install () {
    helm install ${RELEASE_NAME} -n ${NS} --devel -f local_values.yaml \
        oci://ghcr.io/netbox-community/netbox-chart/netbox
}

create_superuser_pass
create_postgres_db
create_redis_secret
helm_install

