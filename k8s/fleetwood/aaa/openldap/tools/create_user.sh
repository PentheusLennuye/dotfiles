#!/usr/bin/env bash

# Create user
DOMAIN="cummings-online.local"
HOST="ldap.${DOMAIN}"
GETSECRET="kubectl get secret ldap-admin -o json"
PASSWORD=$(${GETSECRET} | jq -r '.data.password' | base64 -d)
ADMIN=$(${GETSECRET} | jq -r '.data.username' | base64 -d)
GIDNUMBER=10001  # User

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


[ -n "${initials}" ] && ldif=$(printf "${ldif}\ninitials: $initials")

# RFC 4517 Directory String Syntax enforced by OpenLDAP
uid=
while [ -z "$uid" ]; do
    read  -r -p "Username: " uid
done
ldif=$(printf "${ldif}\nuid: $uid")

ldif=$(cat <<EOF
dn: uid=${uid},${OU}
uid: ${uid}
gidNumber: ${GIDNUMBER}
objectClass: inetOrgPerson
objectClass: posixAccount
cn: $cn
displayName: $cn
givenName: $given_name
sn: $sn
EOF
)

# UIDNumber
# This should be automagic. Maybe set a uidMax on LDAP itself.
read -r -p "UID Value: " uid_number
ldif=$(printf "${ldif}\nuidNumber: $uid_number")

# Home Directory
home_directory="/home/${uid}"
read -r -p "Home Directory [${home_directory}]: " prompt
if [ "${prompt}" != "" ]; then home_directory=$prompt; fi
ldif=$(printf "${ldif}\nhomeDirectory: $home_directory")

# LoginShell
login_shell="/bin/bash"
read -r -p "Login Shell [${login_shell}]: " prompt
if [ "${prompt}" != "" ]; then login_shell=$prompt; fi
ldif=$(printf "${ldif}\nloginShell: $login_shell")

# Mail
mail="${uid}@${DOMAIN}"
read -r -p "Email Address [${mail}]: " prompt
if [ "${prompt}" != "" ]; then mail=$prompt; fi
ldif=$(printf "${ldif}\nmail: $mail")
 
# Create user entry ---------------------------------------------------------
echo "${ldif}" | $add -D "${admin_dn}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "User $uid not created."
    exit 1
fi

# Set default groups ---------------------------------------------------------
echo "Populating group membership"
ldif=$(cat <<EOF
dn: cn=user,$GOU
changetype: modify
add: memberUid
memberUid: $uid
EOF
)

echo "${ldif}" | ldapmodify -x -ZZ \
  -H ldap://${HOST} -D "${admin_dn}" -w "${PASSWORD}"

# Cummings Online Domain Admin
admin=n
read -r -p "Is ${uid} a domain admin? [y/N]: " prompt
if [ "${prompt}" == "y" ]; then
    ldif=$(cat <<EOLD
dn: cn=admin,$GOU
changetype: modify
add: memberUid
memberUid: $uid
EOLD
)
    echo "adding ${uid} to the admin group"
    echo "${ldif}" | ldapmodify -x -ZZ \
    -H ldap://${HOST} -D "${admin_dn}" -w "${PASSWORD}"
fi


# Build the shadow, expiry, and personal info -------------------------------------
#read -r -d '' ldif <<-EOF
#    carLicense: $car_licence
#    co: $country
#    departmentNumber: $departmentNumber
#    description: $description
#    employeeNumber: $employee_number
#    employeeType: $employee_type
#    homePostalAddress: $home_postal_address
#    labeledUrI: $home_page_uri $home_page_name
#    l: $l
#    jpegPhoto: $jpeg_photo_base64
#    manager: $manager
#    mobile: $cell_phone
#    ou: $ou
#    o: $o
#    postalCode
#    preferredLanguage: $preferred_language_utf
#    roomNumber: $room_number
#    sn: $sn
#    st: $st
#    street: $street
#    telephoneNumber: $telephone_number
#    title: $title
#    userSMIMECertificate: $user_smime_certificate_pkcs7_base64
#    userPKCS12: $user_pkcs12_identity_base64
#EOF
#
##echo "${ldif}" | $add -D "${admin_dn}" -w "${PASSWORD}" 
