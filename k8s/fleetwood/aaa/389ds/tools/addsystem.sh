#!/usr/bin/env bash

source ./z_get_env.sh
OU=ou=Systems,${DC}

source ./z_get_creds.sh
source ./z_get_next_computer_uid.sh
GIDNUMBER=10002

# Capture User Info ─────────────────────────────────────────────────────────

ldif=

echo
echo "System essentials"
echo

# RFC 4517 Directory String Syntax enforced by OpenLDAP
cn=
while [ -z "$cn" ]; do
    read  -r -p "Hostname: " hn
    cn=$(echo $hn | tr '[:upper:]' '[:lower:]')
done

description=
while [ -z "$description" ]; do
    read  -r -p "Description: " description
done

l=
while [ -z "$l" ]; do
    read  -r -p "Location: " l
done

owner=
while [ -z "$owner" ]; do
    read  -r -p "Primary User: " owner
done

serialNumber=
while [ -z "$serialNumber" ]; do
    read  -r -p "Serial Number: " serialNumber
done

dn="cn=${cn},${OU}"
ldif=$(cat <<EOF
version: 1
dn: $dn
objectClass: top
objectClass: posixAccount
objectClass: device
cn: $cn
description: $description
gidNumber: $GIDNUMBER
homeDirectory: /dev/null
l: $l
loginShell: /usr/bin/nologin
owner: cn=$owner,ou=People,dc=cummings-online,dc=ca
serialNumber: $serialNumber
uid: ${cn}\$
EOF
)

# UIDNumber
# This should be automagic. Maybe set a uidMax on LDAP itself.
uid_number=$NEW_UIDNUMBER
read -r -p "UID Value [${uid_number}]: " prompt
if [ "${prompt}" != "" ]; then uid_number=$prompt; fi
ldif=$(printf "${ldif}\nuidNumber: $uid_number")

# Create System ───────────────────────────────────────────────────────────────
add="ldapadd -x -ZZ -H ldap://${HOST}"
echo "${ldif}" | $add -D "${ID}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "System $dn not created."
    exit 1
fi

# Domain Systems ------------------------------------------------------------

ldif=$(cat <<EOLD
dn: cn=DomainSystems,$GROUP_OU
changetype: modify
add: uniqueMember
uniqueMember: ${dn}
EOLD
)
    echo "adding ${uid} to the domain systems group"
    echo "${ldif}" | ldapmodify -x -ZZ \
    -H ldap://${HOST} -D "${ID}" -w "${PASSWORD}"
