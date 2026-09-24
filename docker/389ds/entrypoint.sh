#!/usr/bin/env bash

#set -euo pddipefail  Not using pipefail as grep needed

REPLICATION=0
TLS=0

sanity_check() {
  echo "Sanity check"
  if [ -z "${DS_SUFFIX_NAME}" ]; then
    echo "No DS_SUFFIX_NAME defined"
    return 1
  fi
  if [ -z "${HOST_FQDN}" ]; then
    echo "No HOST_FQDN defined"
    return 2
  fi
  if [ -z "${DS_DM_PASSWORD}" ]; then
    echo "No DM_PASSWORD defined"
    return 3
  fi
}

set_tls() {
  echo "Testing for TLS"
  [ -f /data/tls/ca/ca.crt ] || return
  [ -f /data/tls/server.crt ] || return
  [ -f /data/tls/server.key ] || return
  TLS=1
}

set_replication() {
  echo "Testing for Replication"
  if [ "${TLS}" != "1" ]; then echo "TLS off"; return; fi
  if [ -z "${REPLICATION_ROLE}" ]; then echo "No REPLICATION_ROLE"; return; fi
  if [ -z "${REPLICATION_PASSWORD}" ]; then echo "No Repl password"; return; fi
  REPLICATION=1
}

ds_instantiation_1() {
  cat > /root/instance.inf << EOF1
[general]
config_version = 2
full_machine_name = ${HOST_FQDN}
start = no

[slapd]
instance_name = localhost
db_lib = mdb
mdb_max_size = 5G
root_password = ${DS_DM_PASSWORD}
port = 3389
EOF1

}

ds_instantiation_2() {
  if [ "${TLS}" != "1" ]; then
    echo "TLS not configured; not enabling TLS"
    return
  fi

  cat >> /root/instance.inf << EOF2
secure_port = 6636
self_sign_cert = yes
EOF2
}

ds_instantiation_3() {
  cat >> /root/instance.inf << EOF3

[backend-userroot]
create_suffix_entry = no
sample_entries = no
suffix = ${DS_SUFFIX_NAME}
EOF3

}

ds_instantiation_4() {
  if [ "${REPLICATION}" != "1" ]; then
    echo "Replication not configured; not enabling replication"
    return
  fi

  cat >> /root/instance.inf << EOF4
enable_replication = yes
replica_binddn = cn=replication manager,cn=config
replica_bindpw = "${REPLICATION_PASSWORD}"
replica_role = ${REPLICATION_ROLE}

EOF4

}

create_ds_instantiation_file() {
  ds_instantiation_1
  ds_instantiation_2
  ds_instantiation_3
  ds_instantiation_4
  echo "Created instance.inf"
}

create_ds_database() {
  if [ -f /var/lib/dirsrv/slapd-localhost/db/data.mdb ]; then
    echo "DB already exists. Skipping creation."
    return
  fi

  echo "Creating new DB"
  sed -e 's/root_password.*/root_password=MASKED/' \
      -e 's/replica_bindpw.*/reploca_bindpw=MASKED/' \
      /root/instance.inf
  dscreate from-file /root/instance.inf  || exit 7
  rm /root/instance.inf
}

configure_tls() {
  if [ "${TLS}" != "1" ]; then
    "Skipping TLS"
    return
  fi
  echo "Inserting certs to 389ds cert store."
  certutil -L -d /etc/dirsrv/slapd-localhost | grep "ca_cert" 
  if [ $? -eq 0 ]; then
    echo "Server Cert in place. Skipping cert installation." 
    return
  fi

  echo "Installing Server Cert to DS Store"

  cat /etc/dirsrv/slapd-localhost/pin.txt | cut -d: -f2 > /tmp/pinpw

  echo "Removing self-signed cert as they have fulfilled their objective."
  certutil -D -n Self-Signed-CA -d /etc/dirsrv/slapd-localhost
  certutil -D -n Server-Cert -d /etc/dirsrv/slapd-localhost

  certutil -A \
    -d /etc/dirsrv/slapd-localhost \
    -n "ca_cert" \
    -t "C,," \
    -f /tmp/pinpw \
    -i /data/tls/ca/ca.crt

  if [ $? -ne 0 ]; then
    echo "Failed to update CA"
    sleep 5
    exit 1
  fi

  openssl pkcs12 -export \
    -inkey /data/tls/server.key \
    -in /data/tls/server.crt \
    -passout pass: \
    -name "Server-Cert" -out \
    /tmp/server.p12

  pk12util -d /etc/dirsrv/slapd-localhost -i /tmp/server.p12 -W "" -k /tmp/pinpw || return 3
  if [ $? -ne 0 ]; then
    echo "Failed to install server certs"
    sleep 5
    exit 2
  fi
  
  rm /tmp/server.p12 /tmp/pinpw
}

create_replication_agreement() {
  hostname=$1
  agreement_name=$2
  dsconf localhost repl-agmt create \
  --suffix="${DS_SUFFIX_NAME}" --host="${hostname}" --port=636 --conn-protocol=LDAPS \
  --bind-method=SIMPLE --bind-dn="cn=replication manager,cn=config" \
  --bind-passwd="${DS_DM_PASSWORD}" ${agreement_name}

}

create_replication_agreements() {
  if [ "${REPLICATION}" != "1" ]; then
    echo "Replication environment variables not set. Skipping replication"
    return
  fi
  if [ -z "${REPLICATION_PEERS}" ]; then
    echo "No replication peers set"
    return
  fi

  IFS="," read -r -a peers <<< $REPLICATION_PEERS
  for consumer in ${peers[@]}; do
    IFS=":" read -r hostname agreement_name <<< $consumer
    create_replication_agreement $hostname $agreement_name
  done
}


# Kerberos ────────────────────────────────────────────────────────────────────
echo "KRB5_KTNAME=/etc/dirsrv/ds.keytab" > /etc/default/dirsrv


# START HERE
sanity_check
set_tls
set_replication

create_ds_instantiation_file
create_ds_database
dsctl localhost start
configure_tls 
create_replication_agreements
dsctl localhost stop
echo "Entrypoint complete. Passing pid 1 to a389ds localhost"
exec "$@"

