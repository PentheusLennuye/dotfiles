#!/usr/bin/env bash

givenName=$1
sn=$2

# Delete User

source ./z_get_env.sh
source ./z_get_creds.sh

OU="ou=People,${DC}"

delete="ldapdelete -x -ZZ -H ldap://${HOST}"
modify="ldapmodify -x -ZZ -H ldap://${HOST}"
search="ldapsearch -x -ZZ -H ldap://${HOST}"

cn="${givenName} ${sn}"
echo
read  -r -p "Full name to delete [$cn]: " prompt
if [ "${prompt}" != "" ]; then cn=$prompt; fi
dn="cn=${cn},${OU}"

uid=$( $search -D "${ID}" -w "${PASSWORD}" "${dn}" | awk '/uid: / {print $2}')

echo "Deleting user ${cn} (${uid})"

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

