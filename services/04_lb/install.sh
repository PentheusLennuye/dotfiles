#!/usr/bin/env bash

helm repo add metallb https://metallb.github.io/metallb
helm -n metallb-system install metallb metallb/metallb --create-namespace

echo "Sleeping for the CRDs to install."
sleep 30

kubectl apply -f .

