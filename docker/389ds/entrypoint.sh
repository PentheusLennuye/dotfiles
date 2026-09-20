#!/usr/bin/env bash

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
instance_name = service
db_lib = mdb
mdb_max_size = 5G
root_password = ${DS_DM_PASSWORD}
port = 389
EOF1

}

ds_instantiation_2() {
  [[ "${TLS}" != "1" ]] && return

  cat >> /root/instance.inf << EOF2
secure_port = 636
self_sign_cert = no
EOF2
}

ds_instantiation_3() {
  cat >> /root/instance.inf << EOF3

[backend-userroot]
create_suffix_entry = yes
sample_entries = no
suffix = ${DS_SUFFIX_NAME}
EOF3

}

ds_instantiation_4() {
  [[ "${REPLICATION}" != "1" ]] && return

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
  if [ -f /var/lib/dirsrv/slapd-service/db/data.mdb ]; then
    echo "DB already exists. Skipping creation."
    return
  fi

  echo "Creating new DB"
  sed 's/root_password.*/root_password=MASKED/' /root/instance.inf
  dscreate from-file /root/instance.inf  || exit 7
  rm /root/instance.inf
}

configure_tls() {
  [[ "${TLS}" != "1" ]] && return
  certutil -L -d /etc/dirsrv/slapd-service | grep "ca_crt" 
  if [ $? -eq 0 ]; then
    echo "Server Cert in place. Skipping cert installation." 
    return
  fi

  echo "Installing Server Cert to DS Store"

  cat /etc/dirsrv/slapd-service/pin.txt | cut -d: -f2 > /tmp/pinpw

  certutil -A \
    -d /etc/dirsrv/slapd-service \
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

  pk12util -d /etc/dirsrv/slapd-service -i /tmp/server.p12 -W "" -k /tmp/pinpw || return 3
  if [ $? -ne 0 ]; then
    echo "Failed to install server certs"
    sleep 5
    exit 2
  fi
  
  rm /tmp/server.p12 /tmp/pinpw
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
    dsconf service \
      repl-agmt init \
      --suffix="${DS_SUFFIX_NAME}" ${agreement_name}
    echo "Created an agreement for ${hostname} with name ${agreement_name}"
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
configure_tls 
create_replication_agreements

echo "Entrypoint complete. Passing pid 1 to 389ds service"

exec /usr/sbin/dsctl service start

