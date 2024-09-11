#!/usr/bin/env bash

# Install Netbox into Cummings Online Local

NS="cummings-online-local"
RELEASE_NAME=netbox

create_password () {
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

helm_install () {
    helm install ${RELEASE_NAME} -n ${NS} --devel -f local_values.yaml \
        oci://ghcr.io/netbox-community/netbox-chart/netbox
}

#start_ingress() {
#    kubectl -n ${NS} create ingress ${RELEASE_NAME} --class=nginx \
#        --rule="netbox.cummings-online.local/*=netbox:80"
#}


create_password
helm_install
#start_ingress

