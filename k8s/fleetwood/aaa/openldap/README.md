# Cummings Online DIT

Cummings Online DIT is a TLS-enabled directory information tree on port 389.

- TLS is REQUIRED as we are trying this zero-trust thing.
- ldaps (port 636) is deprecated. The pods present 636 for troubleshooting but
  the service shows only port 389. Use STARTTLS (-ZZ for ldap utils).

## Initialize

```sh
./00_create_ldap_secrets.sh  # set cn=admin password
./01_create_ldap_tls.sh      # create a secret with ca chain, cert, key, dh
kubectl apply -f .           # create sldapd deployment and service
./04_custom_config.sh        # permits administration from users inside the dc
```

## Create the service account for ldap authentication

As this LDAP system does not permit anonymous reading of the "people" OU, any
system that needs to find a uidNumber before authentication will require this.

```sh
tools/create_binddn.sh
tools/chpasswd.sh
```

## Create a User

See [tools](tools)

## Test

```sh
ldapsearch -H ldap://ldap.cummings-online.local -ZZ -x -W \
  -D "cn=George Cummings,ou=people,dc=cummings-online,dc=ca" \
  -b "ou=people,dc=cummings-online,dc=ca"
```
