#!/usr/bin/env bash

# Create user


DOMAIN="cummings-online.local"
HOST="ldap.${DOMAIN}"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)

DC="dc=cummings-online,dc=ca"
OU="ou=people,${DC}"

admin_dn="cn=${ADMIN},dc=cummings-online,dc=ca"

# Start --------------------------------------------------
uid=
while [ -z "$uid" ]; do
    read  -r -p "Username: " uid
done
ldif=$(printf "${ldif}\nuid: $uid")

u_password=
while [ -z "$u_password" ]; do
    read -r -s -p "Password: " firstpass
    echo
    read -r -s -p "Confirm password: " secondpass
    echo
    if [ "$firstpass" == "$secondpass" ]; then
        u_password=$firstpass
    else
        echo "Passwords do not match"
    fi
done

# Set password ---------------------------------------------------------
ldappasswd -s "${u_password}" -x -ZZ \
    -H ldap://${HOST} \
    -D "${admin_dn}" -w "${PASSWORD}" \
    "uid=${uid},${OU}"

if [ $? -ne 0 ]; then
    echo "User $uid password not set."
else
    echo "User $uid password set."
fi

