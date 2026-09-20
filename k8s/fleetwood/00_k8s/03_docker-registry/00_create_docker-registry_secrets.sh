#!/usr/bin/env bash
# 
# Create the secret with ca chain, cert, key and dh param
# This does NOT use the secret tls, but rather generic as ca chain and dh
# params need to be separated for bitnomi LDAP.
# 
# The ca bundle must have the name <FQDN>-chain.crt
# The cert and key must have the name <HOSTNAME>.<FQDN>.(crt|key)
# The dh parameter file must have the name <HOSTNAME>.<FQDN>-dhparam.pem

HOSTNAME=docker-registry
DOMAIN=$(hostname -d)
STORE=
TLS_SECRET_NAME=

gather() {
  response=
  read -p "Service hostname [${HOSTNAME}]: " response
  [[ "${response}" == "" ]] || HOSTNAME=$response

  response=
  read -p "Domain [${DOMAIN}]: " response
  [[ "${response}" == "" ]] || DOMAIN=$response

  response=
  STORE=$CA/${DOMAIN}/store
  read -p "Certificate store path [${STORE}]: " response
  [[ "${response}" == "" ]] || STORE=$response

  response=
  TLS_SECRET_NAME=${HOSTNAME}-tls
  read -p "TLS secret name [${TLS_SECRET_NAME}]: " response
  [[ "${response}" == "" ]] || TLS_SECRET_NAME=$response
}

create_tls_secret() {
  KEYFILE=${STORE}/${HOSTNAME}.${DOMAIN}.key
  CERTFILE=${STORE}/${HOSTNAME}.${DOMAIN}-bundle.crt

  for f in $KEYFILE $CACERTFILE; do
    echo "looking for ${f}"
    if [ ! -f $f ]; then
      echo
      echo "$f missing. Exiting."
      echo
      exit 1
    fi
  done

  # TLS for the ingress
  kubectl create secret tls $TLS_SECRET_NAME \
      --namespace it --key=${KEYFILE} --cert=${CERTFILE}
}

create_image_pull_secret() {

  # Secret to attach to pods using this registry
  dockeruser=
  while [[ "${dockeruser}" == "" ]]; do
    read -p "Docker username: " dockeruser
  done
  
  dockeremail=
  while [[ "${dockeremail}" == "" ]]; do
    read -p "Docker email address: " dockeremail
  done
  
  dockerpass=
  while [[ "${dockerpass}" == "" ]]; do
  
    response=
    while [[ "${response}" == "" ]]; do
      read -s -p "${dockeruser}'s password: " response
    done
  
    confirm=
    while [[ "${confirm}" == "" ]]; do
      read -s -p "Confirm ${dockeruser}'s password: " confirm
    done
  
    [[ "${response}" == "${confirm}" ]] && dockerpass=$response
  done
  
  kubectl create secret docker-registry regcred \
    --docker-server=https://${HOSTNAME}.${DOMAIN}/v2/ \
    --docker-username=$dockeruser \
    --docker-password=$dockerpass \
    --docker-email=$dockeremail
}

gather || exit 1
#create_tls_secret || exit 2
create_image_pull_secret || exit 3
