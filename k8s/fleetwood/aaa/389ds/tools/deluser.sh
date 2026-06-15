#!/usr/bin/env bash

# Delete User

source ./z_get_env.sh
source ./z_get_creds.sh

OU="ou=People,${DC}"

delete="ldapdelete -x -ZZ -H ldap://${HOST}"
modify="ldapmodify -x -ZZ -H ldap://${HOST}"

uid=
echo
while [ -z "$uid" ]; do
    read  -r -p "Uid to delete: " uid
done
dn="uid=${uid},${OU}"

echo "Deleting user ${uid}"
$delete -D "${ID}" -w "${PASSWORD}" "${dn}"

# Delete membership from default groups --------------------------------------
ldif=$(cat <<EOF
dn: cn=Users,$GROUP_OU
changetype: modify
delete: memberUid
memberUid: ${uid}

dn: cn=Admins,$GROUP_OU
changetype: modify
delete: memberUid
memberUid: ${uid}
EOF
)

echo "Removing user ${uid} from all known groups"
echo "${ldif}" | $modify -D "${ID}" -w "${PASSWORD}"

