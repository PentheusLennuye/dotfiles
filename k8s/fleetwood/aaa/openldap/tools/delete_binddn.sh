#!/usr/bin/env bash

# Delete BindDN User

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

uid="binddn"
dn="uid=${uid},ou=services,dc=cummings-online,dc=ca"

$delete -D "${admin_dn}" -w "${PASSWORD}" "${dn}"

# Delete membership from default groups --------------------------------------
ldif=$(cat <<EOF
dn: cn=serviceaccount,$GOU
changetype: modify
delete: memberUid
memberUid: ${uid}
EOF
)

echo "${ldif}" | $modify -D "${admin_dn}" -w "${PASSWORD}"

