#!/usr/bin/env bash

NS=it

kubectl -n cert-manager delete cluster-issuer ${NS}-issuer
kubectl -n cert-manager delete secret ${NS}-tls

