#!/usr/bin/env bash

# ┌───────────────────┐
# │ Create BindDN     ├──────────────────────────────────────────────────────┐
# └┬──────────────────┘                                                      │
#  │ Create a non-login account to avoid anonymous directory traversal       │
#  │                                                                         │
#  └─────────────────────────────────────────────────────────────────────────┘


source ./z_get_env.sh
source ./z_get_creds.sh

U=binddn
OU="ou=ServiceAccounts,${DC}"
PRIMARY_GROUP="cn=ServiceAccounts,${GROUP_OU}"


given_name="Bind"
sn="DN"
cn="${given_name} ${sn}"

ldif=$(cat <<EOF
dn: cn=${cn},${OU}
cn: ${cn}
sn: ${sn}
uid: ${U}
objectClass: inetOrgPerson
EOF
)

# Create user entry ---------------------------------------------------------
add="ldapadd -x -ZZ -H ldap://${HOST}"
echo "${ldif}" | $add -D "${ID}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "user $U not created"
else
    echo "user $U created"
fi

# Set default groups ---------------------------------------------------------
echo "Populating group membership"
ldif=$(cat <<EOF
dn: $PRIMARY_GROUP
changetype: modify
add: memberUid
memberUid: ${U}
EOF
)

echo "${ldif}" | ldapmodify -x -ZZ -H ldap://${HOST} -D "${ID}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "user $U not set in group ${GROUP}"
else
    echo "user $U set in group ${GROUP}"
fi

u_password=
while [ -z "$u_password" ]; do
    read -r -s -p "Password: " firstpass
    echo
    read -r -s -p "Confirm password: " secondpass
    echo
    if [ "$firstpass" == "$secondpass" ]; then
        u_password=$firstpass
    else
        echo "passwords do not match"
    fi
done

# Set password ---------------------------------------------------------
echo

ldappasswd -s "${u_password}" -x -ZZ \
    -H ldap://${HOST} \
    -D "${ID}" -w "${PASSWORD}" \
    "cn=${cn},${OU}"

if [ $? -ne 0 ]; then
    echo "user $U password not set"
else
    echo "user $U password set"
fi
