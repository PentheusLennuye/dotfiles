#!/usr/bin/env bash

NS=it
CERTPATHBASE=$1   # e.g. $HOME/tmp/cummings-online.local
VERSION=v1.15.3
REPO=https://github.com/cert-manager/cert-manager

kubectl apply -f ${REPO}/releases/download/${VERSION}/cert-manager.yaml

kubectl -n cert-manager create secret tls ${NS}-tls \
  --cert=$CERTPATHBASE.crt \
  --key=$CERTPATHBASE.key

echo "Sleeping 30s for CRD to appear"
sleep 30

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

