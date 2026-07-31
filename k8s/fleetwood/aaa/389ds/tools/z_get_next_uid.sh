START_NUMBER=10000

set_new_uid() {
  if [ "$1" == "" ]; then
    echo -n $START_NUMBER
  else
    echo $1
  fi
}

LAST_UID=$(
  ldapsearch -x -Z -H ldap://${HOST} -D "${ID}" \
  -w "${PASSWORD}" -b "${DC}" objectClass=posixAccount uidNumber \
  | awk '/uidNumber: / {print $2}' | sort | tail -n 1
)

NEW_UIDNUMBER=$((1 + `set_new_uid $LAST_UID` ))

