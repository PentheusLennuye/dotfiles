#!/usr/bin/env bash

# MetalLB Load Balancer
helm repo add metallb https://metallb.github.io/metallb
helm -n metallb-system install metallb metallb/metallb --create-namespace

# Nginx-Ingress
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace

echo "Sleeping for the CRDs to install."
sleep 15

kubectl apply -f .

