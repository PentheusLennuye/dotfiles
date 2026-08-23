#!/usr/bin/env bash

givenName=$1
sn=$2

source ./z_get_env.sh
source ./z_get_creds.sh

OU="ou=People,${DC}"

# Start --------------------------------------------------
cn="${givenName} ${sn}"
read  -r -p "Full name [${cn}]: " prompt
if [ "${prompt}" != "" ]; then cn=$prompt; fi
ldif=$(printf "${ldif}\ncn: ${cn}")

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
    -D "${ID}" -w "${PASSWORD}" \
    "cn=${cn},${OU}"

if [ $? -ne 0 ]; then
    echo "User $uid password not set."
else
    echo "User $uid password set."
fi

