# Get Started

There are some manual steps required during initial setup. Note that the
examples use _ldap_ and not _ldaps_ as the CA cert is not in the containers.

## A. Internal DNS

As this 389ds uses replication over TLS, the internal pods need to have DNS
pointing to each other's services. This means updating Core DNS.

```sh
KUBE_EDITOR=vim kubectl -n kube-system edit cm coredns  # add entries to ldap, ldap1, ldap2

...
  NodeHosts: |
...
    10.11.0.11 ldap.cummings-online.ca
    10.11.0.15 ldap1.cummings-online.ca
    192.168.73.15 ldap2.cummings-online.ca
...

kubectl -n kube-system rollout restart deploy/coredns
```

## B. Supplier

"Supplier" is 389ds's way of saying master database and system.

```sh
cd supplier
./00_create_ds_dm_password.sh
./01_create_389ds_tls_secret.sh ldap cummings-online.ca \
  /home/gmc/Documents/spaces/tech/infra/ca/cummings-online.ca/store

k apply -f .
```

### B.1 Update TLS

The image does not use /data/tls for replication, so the CA, server crt and key
must be placed into the directory service's trusted store.

```sh
kubectl exec -it deployments/ldap -c dirsrv -- bash

cat /etc/dirsrv/slapd-localhost/pin.txt | cut -d: -f2  # Copy to the clipboard

# Import the CA cert
certutil -A -d /etc/dirsrv/slapd-localhost -n "ca_cert" -t "C,," -i /data/tls/ca/ca.crt

openssl pkcs12 -export -inkey /data/tls/server.key -in /data/tls/server.crt \
  -name "Server-Cert" \
  -out /tmp/server.p12

# Import the pkcs12 into the trusted store
pk12util -d /etc/dirsrv/slapd-localhost -i /tmp/server.p12
rm /tmp/server.p12

exit
```

Restart the supplier:

- `kubectl delete -f 05_389ds_deploy.yaml`
- `kubectl apply -f 05_389ds_deploy.yaml`

### B.2 Create the database

```sh
kubectl exec -it deployments/ldap -c dirsrv -- bash

dsconf -D "cn=Directory Manager" \
ldap://ldap.cummings-online.ca \
backend create \
--suffix="dc=cummings-online,dc=ca" --be-name="cummings-online"

```

Confirm:

```s
dsconf -D "cn=Directory Manager" \
  ldap://ldap.cummings-online.ca \
  backend suffix list
```

You may now exit the terminal for now.

## C. Replication

Replication is not straightforward. The image does not use /data/tls for
replication, so the CA, server crt and key must be placed into the directory
service's trusted store.

### C.1 Consumer Replication Configuration

The "consumer" is the downrange replica servers, generally read-only.

```sh
cd ../consumer
./00_create_ds_dm_password.sh
./01_create_389ds_tls_secret.sh ldap1 cummings-online.ca \
  /home/gmc/Documents/spaces/tech/infra/ca/cummings-online.ca/store

k apply -f .
```

#### C.1.1 Update TLS

```sh
k exec -it deployments/ldap-replica -c dirsrv -- bash

# Import the CA cert
certutil -A -d /etc/dirsrv/slapd-localhost -n "ca_cert" -t "C,," -i /data/tls/ca/ca.crt

openssl pkcs12 -export -inkey /data/tls/server.key -in /data/tls/server.crt \
  -name "Server-Cert" \
  -out /tmp/server.p12

# Import the pkcs12 into the trusted store
cat /etc/dirsrv/slapd-localhost/pin.txt | cut -d: -f2  # Copy to the clipboard
pk12util -d /etc/dirsrv/slapd-localhost -i /tmp/server.p12
rm /tmp/server.p12

exit
```

Restart the consumer:

- `kubectl delete -f 04_389ds_deploy.yaml`
- `kubectl apply -f 04_389ds_deploy.yaml`

#### C.1.2 Create the backend database

```sh
k exec -it deployments/ldap-replica -c dirsrv -- bash

dsconf -D "cn=Directory Manager" \
  ldap://ldap1.cummings-online.ca \
  backend create \
  --suffix="dc=cummings-online,dc=ca" \
  --be-name="cummings-online"
```

Repeat this command, waiting, until the backend appears:

```sh
dsconf -D "cn=Directory Manager" \
  ldap://ldap1.cummings-online.ca \
  backend suffix list
```

#### C.1.3 Set up replication

```sh
echo -n "Set replication password"
read -s rpwd

dsconf -D "cn=Directory Manager" \
  ldap://ldap1.cummings-online.ca \
  replication enable \
  --suffix="dc=cummings-online,dc=ca" \
  --role="consumer" \
  --bind-dn="cn=replication manager,cn=config" \
  --bind-passwd="${rpwd}"

exit
```

### C.2 Supplier Replication Configuration

```sh
cd ../supplier
k exec -it deployments/ldap -c dirsrv -- bash

echo -n "Set replication password"
read -s rpwd

dsconf -D "cn=Directory Manager" \
  ldap://ldap.cummings-online.ca \
  replication enable \
  --suffix="dc=cummings-online,dc=ca" \
  --role="supplier" \
  --replica-id=1

dsconf -D "cn=Directory Manager" \
  ldap://ldap.cummings-online.ca \
  repl-agmt create \
  --suffix="dc=cummings-online,dc=ca" \
  --host="ldap1.cummings-online.ca" \
  --port=636 \
  --conn-protocol=LDAPS \
  --bind-dn="cn=replication manager,cn=config" \
  --bind-passwd="${rpwd}" \
  --bind-method=SIMPLE --init fleetwood-agreement

dsconf -D "cn=Directory Manager" \
  ldap://ldap.cummings-online.ca \
  repl-agmt init \
  --suffix="dc=cummings-online,dc=ca" fleetwood-agreement
```

Confirm

```sh
dsconf -D "cn=Directory Manager" \
  ldap://ldap.cummings-online.ca \
  repl-agmt init-status \
  --suffix="dc=cummings-online,dc=ca" fleetwood-agreement
```

## D. Populate away

```sh
export cn="cn=Directory Manager"
read -s pass
export pass
./07_populate.sh
```
