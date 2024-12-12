# Netbox

The helm chart is somewhat flawed as of version 5.0.0.

The superuser does not seem to grab its secrets as advertised. It does not even
set the admin password to the default. One will need to _exec_ into the netbox
host and:

1. `source /opt/netbox/venv/bin/activate`
2. `./manage createsuperuser`. Do not use _admin_, it is already taken.
3. Log into the netbox UI as the new superuser, click on __Admin > Users__, and
   delete the unknown admin account.
