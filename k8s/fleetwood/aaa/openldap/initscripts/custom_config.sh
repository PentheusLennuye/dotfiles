#!/usr/bin/bash

CURDIR=/docker-entrypoint-initdb.d/initscripts

echo "Adding uid index"
ldapmodify -Y EXTERNAL -H "ldapi:///" -f $CURDIR/reconfigure.ldif 

echo "Creating the ACL"
ldapmodify -Y EXTERNAL -H "ldapi:///" -f $CURDIR/acl.ldif 

