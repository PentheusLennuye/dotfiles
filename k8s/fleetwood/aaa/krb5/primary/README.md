# KRB Master README

Two things that need to be fixed with an initContainer:

1. ktadd the principal to /etc/krb5.keytab
2. Create a cronjob
3. Run crond -b

```sh
5,20,35,50 * * * * /usr/sbin/kdb5_util dump /var/lib/krb5kdc/dump && /usr/sbin/kprop -r CUMMINGS-ONLINE.CA -f /var/lib/krb5kdc/dump krb2.cummings-online.ca
```
