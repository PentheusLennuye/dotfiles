# Get Started

There are some manual steps required during initial setup.

```sh
./00_create_ds_dm_password.sh
./01_create_389ds_tls_secret.sh <hostname> cummings-online.ca /home/gmc/Documents/spaces/tech/infra/ca/cummings-online.ca/store

k apply -f .
```

Wait a bit.

```sh
export cn="cn=Directory Manager"
export pass=$(read -s)
k exec -it deployments/ldap -- bash

dsconf -D "cn=Directory Manager" backend create \
  --suffix="dc=cummings-online,dc=ca" --be-name="cummings-online"
exit
```

Populate away

```sh
./07_populate.sh
```
