#!/usr/bin/env bash
#
# Install the AWX Operator
#
# This permits easy AWX instance installation. Cookie-cutter even.
#
# ---------------------------------------------------------------------------

NS=cummings-online-local
VERSION=2.19.1

create_postgres_db() {
  echo -n "Postgres AWX db password: "
  read -s db_password
  echo
  echo -n "Confirm AWX db password: "
  read -s confirm_password
  echo

  if [[ "${db_password}" != "${confirm_password}" ]]
  then
    echo "passwords do not match"
    exit 1
  fi

  kubectl -n ${NS} create secret generic \
    awx-db-credentials \
    --from-literal=host=postgres \
    --from-literal=port=5432 \
    --from-literal=database=awx \
    --from-literal=username=awx \
    --from-literal=password=${db_password} \
    --from-literal=sslmode=prefer \
    --from-literal=target_sessions_attrs=read-write \
    --from-literal=type=unmanaged

  POD=$(kubectl -n cummings-online-local get po \
      | grep postgres | awk '{print $1}')
        

  kubectl -n ${NS} exec -i ${POD} -- psql -d postgres -U postgres << EOF
CREATE ROLE awx WITH LOGIN PASSWORD '${db_password}';
CREATE DATABASE awx OWNER awx;
GRANT CREATE ON SCHEMA public TO awx;
EOF
}

create_awx_instance() {
  cat <<EOF | kubectl create -f -
apiVersion: awx.ansible.com/v1beta1
kind: AWX
metadata:
  name: awx
  namespace: cummings-online-local
spec:
  service_type: clusterip
  postgres_configuration_secret: awx-db-credentials
EOF
}

create_postgres_db
kubectl apply -k .
echo "Sleeping 10s for CRD install."
create_awx_instance

cat <<EOM
Get the admin password with
kubectl -n cummings-online-local get secret awx-admin-password \
  -o jsonpath="{.data.password}" | base64 -d
EOM

