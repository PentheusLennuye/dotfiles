#!/usr/bin/env bash

# Delete BindDN User

source ./z_get_creds.sh

HOST="ldap.cummings-online.ca"

U=binddn
DC="dc=cummings-online,dc=ca"
OU="ou=ServiceAccounts,${DC}"
DN="cn=Bind DN,${OU}"

delete="ldapdelete -x -ZZ -H ldap://${HOST}"
modify="ldapmodify -x -ZZ -H ldap://${HOST}"

echo "Deleting ${dn}"
$delete -D "${ID}" -w "${PASSWORD}" "${DN}"

# Delete membership from default groups --------------------------------------
GOU="ou=Groups,${DC}"
PRIMARY_GROUP="cn=ServiceAccounts,${GOU}"

ldif=$(cat <<EOF
dn: $PRIMARY_GROUP
changetype: modify
delete: uniqueMember
uniqueMember: ${DN}
EOF
)

echo "Removing ${U} from ${PRIMARY_GROUP}"
echo "${ldif}" | $modify -D "${ID}" -w "${PASSWORD}"

