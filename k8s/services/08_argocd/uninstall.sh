#!/usr/bin/env bash

# Uninstall Netbox from Cummings Online Local

NS="cummings-online-local"
kubectl -n $NS delete -f argocd.yaml
