#!/usr/bin/env bash

sudo apt install sssd-ldap ldap-utils

sudo echo "session\toptional\t\tpam_mkhomedir.so" >> /etc/pam.d/common-session

