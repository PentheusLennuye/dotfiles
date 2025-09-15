#!/usr/bin/env bash
# Configure OpenLDAP my way


# This uses OpenLDAP's dynamic configuration schema. Bitnami permit any script
# to execute in /docker-entrypoint-initdb.d/. However, we aren't using an NFS
# volume mount (yet) so we'll just copy things manually and execute them here.

po=$(kubectl -n it get po | awk '{print $1}' | grep ldap | head -n 1)
echo "Copying to $po"
kubectl -n it cp initscripts ${po}:/docker-entrypoint-initdb.d/
echo "Executing dynamic config on ldap"
#kubectl exec ${po} -- /docker-entrypoint-initdb.d/initscripts/custom_config.sh
kubectl exec -t deployments/ldap -- \
  /docker-entrypoint-initdb.d/initscripts/custom_config.sh

echo "Populating"
admin=$(kubectl -n it get secret ldap-admin -o json \
    | jq -r .data.username | base64 -d)

password=$(kubectl -n it get secret ldap-admin -o json \
    | jq -r .data.password | base64 -d)

ldapadd -x -ZZ \
    -H ldap://ldap.cummings-online.local \
    -D cn=${admin},dc=cummings-online,dc=ca \
    -w "${password}" \
    -f populate/populate.ldif
