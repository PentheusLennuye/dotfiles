#!/usr/bin/env bash


source ./z_get_env.sh
source ./z_get_creds.sh
OU="ou=People,${DC}"

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
    -D "${ID}" -w "${PASSWORD}" \
    "uid=${uid},${OU}"

if [ $? -ne 0 ]; then
    echo "User $uid password not set."
else
    echo "User $uid password set."
fi

