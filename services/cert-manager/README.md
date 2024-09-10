# Cert Manager

Cummings Local uses its own local CA issuer. As such, the tls.key and tls.crt
cannot be saved to the dotfiles repo.

As I own the cluster, no need for separate namespaces. The intermediate chain
will go into the cluster namespace "cert-manager".

