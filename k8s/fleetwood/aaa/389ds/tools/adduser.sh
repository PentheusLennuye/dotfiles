#!/usr/bin/env bash

givenName=$1
sn=$2

source ./z_get_env.sh
source ./z_get_creds.sh
source ./z_get_next_uid.sh

ADMINS=10000
USERS=10001
OU="ou=People,${DC}"

# Capture User Info ─────────────────────────────────────────────────────────

ldif=

echo
echo "User essentials"
echo
read -r -p "Given name [${givenName}]: " prompt
if [ "${prompt}" != "" ]; then givenName=$prompt; fi
read -r -p "Family name [${sn}]: " prompt
if [ "${prompt}" != "" ]; then sn=$prompt; fi
read -r -p "Optional middle name or initials: " initials
cn="${givenName} ${sn}"
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
dn: cn=${cn},${OU}
uid: ${uid}
gidNumber: ${USERS}
objectClass: inetOrgPerson
objectClass: posixAccount
cn: $cn
displayName: $cn
givenName: $givenName
sn: $sn
EOF
)

# UIDNumber
# This should be automagic. Maybe set a uidMax on LDAP itself.
uid_number=$NEW_UIDNUMBER
read -r -p "UID Value [${uid_number}]: " prompt
if [ "${prompt}" != "" ]; then uid_number=$prompt; fi
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
mail="${uid}@${EXT_DOMAIN}"
read -r -p "Email Address [${mail}]: " prompt
if [ "${prompt}" != "" ]; then mail=$prompt; fi
ldif=$(printf "${ldif}\nmail: $mail")
 
# Create User ────────────────────────────────────────────────────────────────
add="ldapadd -x -ZZ -H ldap://${HOST}"
echo "${ldif}" | $add -D "${ID}" -w "${PASSWORD}"
if [ $? -ne 0 ]; then
    echo "User $uid not created."
    exit 1
fi

# Set default groups ---------------------------------------------------------
echo "Populating group membership"
ldif=$(cat <<EOF
dn: cn=Users,$GROUP_OU
changetype: modify
add: uniqueMember
uniqueMember: cn=${cn},${OU}
EOF
)

echo "${ldif}" | ldapmodify -x -ZZ \
  -H ldap://${HOST} -D "${ID}" -w "${PASSWORD}"

# Cummings Online Domain Admin
admin=n
read -r -p "Is ${cn} a domain admin? [y/N]: " prompt
if [ "${prompt}" == "y" ]; then
    ldif=$(cat <<EOLD
dn: cn=Admins,$GROUP_OU
changetype: modify
add: uniqueMember
uniqueMember: cn=${cn},${OU}
EOLD
)
    echo "adding ${uid} to the admin group"
    echo "${ldif}" | ldapmodify -x -ZZ \
    -H ldap://${HOST} -D "${ID}" -w "${PASSWORD}"
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

# Set password ---------------------------------------------------------
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

ldappasswd -s "${u_password}" -x -ZZ \
    -H ldap://${HOST} \
    -D "${ID}" -w "${PASSWORD}" \
    "cn=${cn},${OU}"

if [ $? -ne 0 ]; then
    echo "User $uid password not set."
else
    echo "User $uid password set."
fi

