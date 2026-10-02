#!/usr/bin/env bash

hostname=$1

# Delete User

source ./z_get_env.sh
source ./z_get_creds.sh

OU="ou=Systems,${DC}"

delete="ldapdelete -x -ZZ -H ldap://${HOST}"
modify="ldapmodify -x -ZZ -H ldap://${HOST}"
search="ldapsearch -x -ZZ -H ldap://${HOST}"

cn=${hostname}
echo
read  -r -p "Hostname to delete [$cn]: " prompt
if [ "${prompt}" != "" ]; then cn=$prompt; fi
dn="cn=${cn},${OU}"

echo "Deleting system ${cn}"

$delete -D "${ID}" -w "${PASSWORD}" "${dn}"

# Delete membership from default groups --------------------------------------
ldif=$(cat <<EOF
dn: cn=DomainSystems,$GROUP_OU
changetype: modify
delete: uniqueMember
uniqueMember: ${cn},${OU}
EOF
)

echo "Removing system ${cn} from all known groups"
echo "${ldif}" | $modify -D "${ID}" -w "${PASSWORD}"

