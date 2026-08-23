# Get credentials ────────────────────────────────────────────────────────────
CALLER="Directory Manager"
ID=
read -r -p "Administrator name [${CALLER}]: " U
if [ "${U}" == "" ]; then
  ID="cn=${CALLER}"
else
  ID="cn${U},ou=People,${DC}"
fi

PASSWORD=
while [ "${PASSWORD}" == "" ]; do
  read -r -s -p "Password: " PASSWORD
done

