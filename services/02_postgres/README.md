# Postgresql

This creates a single postgresql instance usable by all pods. It uses local
data as this meant for a single k8s host in a lab.

## Usage:

```sh
./00_create_admin_secret.sh
kubectl apply -f .
```

