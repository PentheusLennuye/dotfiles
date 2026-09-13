#!/usr/bin/env bash
# Configure 389 Directory Service my way

password=$(kubectl -n it get secret ds-dm-password -o json \
    | jq -r .data.password | base64 -d)

echo "This is dangerous. Type 'yes' to wipe out the ACI's: "
read answer

[ "${answer}" == "yes" ] || exit

echo "clearing ACI's"

ldapmodify -x -ZZ \
    -H ldap://ldap.cummings-online.ca \
    -D cn="Directory Manager" \
    -w "${password}" <<EOF
dn: dc=cummings-online,dc=ca
changetype: modify
delete: aci

EOF

ldapmodify -x -ZZ \
    -H ldap://ldap.cummings-online.ca \
    -D cn="Directory Manager" \
    -w "${password}" <<EOF
dn: ou=People,dc=cummings-online,dc=ca
changetype: modify
delete: aci

EOF
