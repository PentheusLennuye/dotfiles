#!/usr/bin/env bash

# Install ArgoCD into Cummings Online Local

NS="cummings-online-local"
kubectl -n $NS apply -f argocd.yaml

