#!/usr/bin/env bash
#
# Install the AWX Operator
#
# This permits easy AWX instance installation. Cookie-cutter even.
#
# ---------------------------------------------------------------------------

VERSION=2.19.1
NS=cummings-online-local

kubectl delete -f .
kubectl -n ${NS} delete secret awx-db-credentials

kubectl delete \ 
    https://github.com/ansible/awx-operator/config/default?ref=$VERSION

