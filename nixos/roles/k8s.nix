{ ... }:

{
    services.k3s = {
        enable = true;
        role = "server";
        extraFlags = toString [ "--disable=traefik" ];
    };
}
