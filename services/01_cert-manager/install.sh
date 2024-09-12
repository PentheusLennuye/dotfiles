#!/usr/bin/env bash

NS=cummings-online-local
CERTPATHBASE=$1   # e.g. $HOME/tmp/cummings-online.local
VERSION=v1.15.3
REPO=https://github.com/cert-manager/cert-manager

kubectl apply -f ${REPO}/releases/download/${VERSION}/cert-manager.yaml

kubectl -n cert-manager create secret tls ${NS}-tls \
  --cert=$CERTPATHBASE.crt \
  --key=$CERTPATHBASE.key

cat <<EOF | kubectl create -f -
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: ${NS}-issuer
spec:
  ca:
    secretName: ${NS}-tls
EOF

kubectl apply -f issuer.yaml
