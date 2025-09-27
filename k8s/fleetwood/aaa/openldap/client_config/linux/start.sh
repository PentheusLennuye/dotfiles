#!/usr/bin/env bash

sudo apt install sssd-ldap ldap-utils

sudo echo "session optional pam_mkhomedir.so" >> /etc/pam.d/common-session

sudo cp cummings-online.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

