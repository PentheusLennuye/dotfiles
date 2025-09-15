#!/usr/bin/env bash

# Create binddn for non-anonymous ldap identification
DOMAIN="cummings-online.local"
HOST="ldap.${DOMAIN}"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)

DC="dc=cummings-online,dc=ca"
OU="ou=services,${DC}"
GOU="cn=serviceaccount,ou=groups,${DC}"

admin_dn="cn=${ADMIN},dc=cummings-online,dc=ca"
add="ldapadd -x -ZZ -H ldap://${HOST}"

given_name="Bind"
sn="DN"
cn="${given_name} ${sn}"
uid="binddn"

ldif=$(cat <<EOF
dn: uid=binddn,${OU}
cn: BindDN
sn: BindDN
uid: binddn
objectClass: inetOrgPerson
EOF
)

# Create user entry ---------------------------------------------------------
echo "${ldif}" | $add -D "${admin_dn}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "user $uid not created"
else
    echo "user $uid created"
fi

# Set default groups ---------------------------------------------------------
echo "Populating group membership"
ldif=$(cat <<EOF
dn: $GOU
changetype: modify
add: memberUid
memberUid: $uid
EOF
)

echo "${ldif}" | ldapmodify -x -ZZ -H ldap://${HOST} -D "${admin_dn}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "user $uid not set in group ${GOU}"
else
    echo "user $uid set in group ${GOU}"
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
    -D "${admin_dn}" -w "${PASSWORD}" \
    "uid=binddn,${OU}"

if [ $? -ne 0 ]; then
    echo "user $uid password not set"
else
    echo "user $uid password set"
fi
