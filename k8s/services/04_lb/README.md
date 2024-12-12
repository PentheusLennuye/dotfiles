# LoadBalancer

This directory has two items:

1. The MetalLB Load Balancer
2. Ngix-ingress ingress controller.

## Load Balancer

This intercepts ARP calls for a certain IP address and effectively takes it
over without one having to bind the IP to a NIC. Services using the type
"LoadBalancer" can specify which IP from the pool it wants.

## Ingress Controller

If using K3S, forget it. It comes already furnished with Traefik.

Otherwise:
Load Balancers do not deal with TLS. If a service has an ingress controller
attached to it, then the load balancer will send traffic to the ingress
controller, and thence to the service.
