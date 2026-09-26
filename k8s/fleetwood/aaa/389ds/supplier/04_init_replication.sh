#!/usr/bin/env bash
# Start the replication to ldap1 and ldap2

echo "Initializing replication"

kubectl exec deploy/ldap -- dsconf localhost repl-agmt init \
  --suffix="dc=cummings-online,dc=ca" fleetwood-1

kubectl exec deploy/ldap -- dsconf localhost repl-agmt init \
  --suffix="dc=cummings-online,dc=ca" fleetwood-2

sleep 5
echo -n "Status of agreement fleetwood-1..."
kubectl exec deploy/ldap -- dsconf localhost repl-agmt init-status \
  --suffix="dc=cummings-online,dc=ca" fleetwood-1

echo -n "Status of agreement fleetwood-2..."
kubectl exec deploy/ldap -- dsconf localhost repl-agmt init-status \
  --suffix="dc=cummings-online,dc=ca" fleetwood-2
