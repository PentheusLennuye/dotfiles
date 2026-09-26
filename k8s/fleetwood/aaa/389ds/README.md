# Get Started

There are some manual steps required during initial setup. Note that the
examples use _ldap_ and not _ldaps_ as the CA cert is not in the containers.

## A. Preparation

### A.1 Internal DNS

As this 389DS uses replication over TLS, the internal pods need to have DNS
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

### A.2 Persistent Volumes

You will want your precious data to be persistent. Ensure each host has this
directory structure:

```text
/
├─ data (owned by root)
├─ config (owned by 100:101)
└─ logs (owned by 100:101)
```

### A.4 Create the directory manager secret

```sh
./00_create_ds_dm_password.sh
```

## B. Consumer

Replication is enabled, but not initialized.

### B.1 Consumer Replication Configuration

#### B.1.1 Create the consumer

The "consumer" is the downrange replica servers, generally read-only. They
should be created first.

```sh
cd consumer
./01_create_389ds_tls_consumer_secret.sh
k apply -f .
```

## C. Supplier

"Supplier" is 389ds's way of saying master database and system.

```sh
cd ../supplier
./01_create_389ds_tls_secret.sh
k apply -f .
./07_populate.sh
```

### C.1 Initial agreement

On occasion, the agreement will stay in state unknown. Initiate with the
following command for each agreement:

```sh
kubectl exec deploy/ldap -- dsconf localhost repl-agmt init \
--suffix="dc=cummings-online,dc=ca" <agreement name>
```

## D. Troubleshooting

If the replication manager password on a host not controlled by container
images is incorrect, fix it with:

```sh
ldapmodify -x -D "cn=Directory Manager" -W -H ldap://localhost:389 << EOF
dn: cn=replication manager,cn=config
changetype: modify
replace: userPassword
userPassword: <new_replication_manager_password>
EOF
```
