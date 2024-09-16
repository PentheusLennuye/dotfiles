#!/usr/bin/env bash
#
# Install the AWX Operator
#
# This permits easy AWX instance installation. Cookie-cutter even.
#
# ---------------------------------------------------------------------------

VERSION=2.19.1
NS=cummings-online-local

kubectl delete -f awx.yml
kubectl -n ${NS} delete secret awx-db-credentials
kubectl delete -k kustomization.yml

