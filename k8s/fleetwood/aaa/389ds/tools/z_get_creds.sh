# Get credentials ────────────────────────────────────────────────────────────
CALLER="Directory Manager"
ID=
read -r -p "Administrator username [${CALLER}]: " U
if [ "${U}" == "" ]; then
  ID="cn=${CALLER}"
else
  ID="uid=${U}"
fi

PASSWORD=
while [ "${PASSWORD}" == "" ]; do
  read -r -s -p "Password: " PASSWORD
done

