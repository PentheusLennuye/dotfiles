#!/usr/bin/env bash

# MetalLB Load Balancer
helm repo add metallb https://metallb.github.io/metallb
helm -n metallb-system install metallb metallb/metallb --create-namespace

kubectl apply -f ipaddresspool.yaml
kubectl apply -f l2advertisement.yaml

echo "Sleeping for the CRDs to install."
sleep 10


# Nginx-Ingress
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace \
  -f local_nginx_values.yaml

kubectl apply -f ingress.yaml

