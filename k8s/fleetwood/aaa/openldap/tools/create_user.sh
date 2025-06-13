#!/usr/bin/env bash

# Create user

HOST="ldap.cummings-online.local"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)

DC="dc=cummings-online,dc=ca"
OU="ou=people,${DC}"
GOU="ou=groups,${DC}"

admin_dn="cn=${ADMIN},dc=cummings-online,dc=ca"
add="ldapadd -x -ZZ -H ldap://${HOST}"

ldif=

read -r -p "Given name: " given_name
read -r -p "Family name: " sn
read -r -p "Optional middle name or initials: " initials
cn="${given_name} ${sn}"
read -r -p "Preferred Name [${cn}]: " hn
[ -n "$hn" ] && cn="$hn"

ldif=$(cat <<EOF
dn: cn=$cn,${OU}
objectClass: inetOrgPerson
objectClass: posixAccount
cn: $cn
displayName: $cn
givenName: $given_name
sn: $sn
gidNumber: 10001
homeDirectory: /home/gmc
EOF
)

[ -n "${initials}" ] && ldif=$(printf "${ldif}\ninitials: $initials")

# RFC 4517 Directory String Syntax enforced by OpenLDAP
uid=
while [ -z "$uid" ]; do
    read  -r -p "Username: " uid
done

ldif=$(printf "${ldif}\nuid: $uid")

# This should be automagic. Maybe set a uidMax on LDAP itself.
read -r -p "UID Value: " uid_number
ldif=$(printf "${ldif}\nuidNumber: $uid_number")
 
# RFC 4519 LDAP Schema for User Applications
# RFC 4517 Octet String 1.3.6.1.4.1.1466.115.121.1.40
# Password to be transcoded to Unicode, prepped with SASLprep (RFC4013)
# and encoded as UTF-8. This will be done __ldappasswd__.
password=
while [ -z "$password" ]; do
    read -r -s -p "Password: " firstpass
    echo
    read -r -s -p "Confirm password: " secondpass
    echo
    if [ "$firstpass" == "$secondpass" ]; then
        password=$firstpass
    else
        echo "Passwords do not match"
    fi
done

echo "Creating user"
echo "${ldif}" | $add -D "${admin_dn}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "User $uid not created."
    exit 1
fi

ldif=$(cat <<EOF
dn: cn=reader,$GOU
changetype: modify
add: memberUid
memberUid: $uid

dn: cn=users,$GOU
changetype: modify
add: memberUid
memberUid: $uid
EOF
)

echo "${ldif}" | ldapmodify -x -ZZ -H ldap://${HOST} -D "${admin_dn}" -w "${PASSWORD}"
ldappasswd -s "$password" -x -ZZ -H ldap://${HOST} -D "${admin_dn}" -w "${PASSWORD}" "cn=${cn},${OU}"
if [ $? -ne 0 ]; then
    echo "User $uid password not set."
    exit 1
fi

echo "User created"

# Build the shadow, expiry, and personal info -------------------------------------
#read -r -d '' ldif <<-EOF
#    carLicense: $car_licence
#    departmentNumber: $departmentNumber
#    description: $description
#    employeeNumber: $employee_number
#    employeeType: $employee_type
#    homePostalAddress: $home_postal_address
#    gidNumber: $primary_group_id
#    labeledUrI: $home_page_uri $home_page_name
#    l: $l
#    jpegPhoto: $jpeg_photo_base64
#    mail: $email
#    manager: $manager
#    mobile: $cell_phone
#    ou: $ou
#    o: $o
#    preferredLanguage: $preferred_language_utf
#    roomNumber: $room_number
#    sn: $sn
#    st: $st
#    street: $street
#    telephoneNumber: $telephone_number
#    title: $title
#    uid: $uid
#    uidNumber: $uid_number
#    userPassword: $password_sha512
#    userSMIMECertificate: $user_smime_certificate_pkcs7_base64
#    userPKCS12: $user_pkcs12_identity_base64
#EOF
#
##echo "${ldif}" | $add -D "${admin_dn}" -w "${PASSWORD}" 
