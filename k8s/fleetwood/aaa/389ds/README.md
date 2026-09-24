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

### A.2 Kerberos

If using Kerberos for password-less queries, create a _krb5.conf_ and one
_ds.keytab_ (the equivalent of _krb5.keytab_) per host. They need to be made
available on a persistent volume, configuration map, or secret.

The keytab principles must have the prefix _ldap/_.

### A.3 Persistent Volumes

You will want your precious data to be persistent. Ensure each host has this
directory structure:

```text
/
├─ data (owned by root)
├─ config (owned by 100:101)
│    ├─ krb5.conf
│    └─ ds.keytab
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

## F. GSSAPI/Kerberos

### F.1 Docker Containers

Confirm GSSAPI and GSS-SPNEGO are available:

```sh
dsconf -D "cn=Directory Manager" ldap://ldap1.cummings-online.ca config get nsslapd-allowed-sasl-mechanisms
```

If they are not, punch in the following command:

```sh
dsconf -D "cn=Directory Manager" ldap://ldap.cummings-online.ca config \
  replace nsslapd-allowed-sasl-mechanisms=PLAIN,EXTERNAL,LOGIN,GSSAPI,GSS-SPNEGO
```

### F.2 Ubuntu
