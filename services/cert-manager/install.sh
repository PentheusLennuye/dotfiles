#!/usr/bin/env bash

CERTPATHBASE=$1   # e.g. $HOME/tmp/cummings-online.local
VERSION=v1.15.3
REPO=https://github.com/cert-manager/cert-manager

kubectl apply -f ${REPO}/releases/download/${VERSION}/cert-manager.yaml

kubectl -n cert-manager create secret tls cummings-online-local-tls \
  --cert=$CERTPATHBASE.crt \
  --key=$CERTPATHBASE.key

cat <<EOF >issuer.yaml
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: cummings-local-issuer
spec:
  ca:
    secretName: cummings-online-local-tls
EOF

kubectl apply -f issuer.yaml
