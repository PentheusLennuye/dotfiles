#!/usr/bin/env bash

# Delete User

HOST="ldap.cummings-online.local"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)

DC="dc=cummings-online,dc=ca"
OU="ou=people,${DC}"
GOU="ou=groups,${DC}"

admin_dn="cn=${ADMIN},${DC}"
delete="ldapdelete -x -ZZ -H ldap://${HOST}"
modify="ldapmodify -x -ZZ -H ldap://${HOST}"

dn="uid=gmc,ou=people,dc=cummings-online,dc=ca"
uid="10001"

$delete -D "${admin_dn}" -w "${PASSWORD}" "${dn}"

# Delete membership from default groups --------------------------------------
ldif=$(cat <<EOF
dn: cn=reader,$GOU
changetype: modify
delete: memberUid

dn: cn=users,$GOU
changetype: modify
delete: memberUid
EOF
)

echo "${ldif}" | $modify -D "${admin_dn}" -w "${PASSWORD}"

