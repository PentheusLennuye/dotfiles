#!/usr/bin/env bash

sudo apt install -y ldap-utils krb5-user sssd-krb5 sssd-ldap

echo "session optional pam_mkhomedir.so" | sudo tee -a /etc/pam.d/common-session

sudo cp ../../../openldap/client_config/cummings-online.crt \
    /usr/local/share/ca-certificates/
sudo update-ca-certificates

sudo cp krb5.conf /etc/krb5.conf
sudo cp ../../../openldap/client_config/ldap.conf /etc/ldap/ldap.conf

sudo cp sssd.conf.template /etc/sssd/sssd.conf
sudo vi /etc/sssd/sssd.conf  # change the binddn

sudo systemctl start sssd.service
