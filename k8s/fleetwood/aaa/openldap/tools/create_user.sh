#!/usr/bin/env bash

# Create user

HOST="ldap.cummings-online.local"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)

OU="ou=people,dc=cummings-online,dc=ca"

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
dn: $cn,${OU}
objectClass: person 
objectClass: organizationalPerson
objectClass: inetOrgPerson
cn: $cn
displayName: $cn
givenName: $given_name
EOF
)

[ -n "${initials}" ] && ldif=$(printf "${ldif}\ninitials: $initials")

uid



password=
while [ -z "$password" ]; do
    read


# uidNumber

# Build the LDIF -------------------------------------
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
#
echo "${ldif}"
