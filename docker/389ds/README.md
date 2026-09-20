# Cummings 389DS

The famous 389DS directory service using LDAP.

Inspired by the official 389DS, but using the Ubuntu base image and simple
flags for replication and GSSAPI.

## Building

```sh
docker buildx build --tag REGISTRY/REPO:TAG
docker push REGISTRY/REPO
```
