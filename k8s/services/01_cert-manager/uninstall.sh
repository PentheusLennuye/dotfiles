#!/usr/bin/env bash

NS=cummings-online-local
CERTPATHBASE=$1   # e.g. $HOME/tmp/cummings-online.local
VERSION=v1.15.3
REPO=https://github.com/cert-manager/cert-manager

kubectl -n cert-manager delete cluster-issuer ${NS}-issuer
kubectl -n cert-manager delete secret ${NS}-tls

