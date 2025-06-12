# LoadBalancer

This directory has one item:

1. The MetalLB Load Balancer

## Load Balancer

This intercepts ARP calls for a certain IP address and effectively takes it
over without one having to bind the IP to a NIC. Services using the type
"LoadBalancer" can specify which IP from the pool it wants.

