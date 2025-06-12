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

```
