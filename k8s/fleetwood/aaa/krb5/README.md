# Cummings Online DIT

Cummings Online DIT is a TLS-enabled directory information tree on port 389.

- TLS is REQUIRED as we are trying this zero-trust thing.
- ldaps (port 636) is deprecated. The pods present 636 for troubleshooting but
  the service shows only port 389. Use STARTTLS (-ZZ for ldap utils).

## Initialize

```sh
./00_create_krb5_secrets.sh  # set krb admin password for the db
kubectl apply -f .           # create krb5 kdc and admin server
```

## Test

Using _client_config/start.sh_ on a Debian VM somewhere run this command:

```sh
kinit admin/admin@CUMMINGS-ONLINE.CA

# prompts for password

klist
```

## Add User Principals

On any Debian VM with the krb5-user set up, create users thus:

```sh
kadmin

addprinc <username>
quit
```

## Configure the Client to use KRB5

See [client_config](client_config/start.sh).

### Test

Log in to a KRB-enabled client and check if the principal is around

```sh
ssh <client host>
klist
```
