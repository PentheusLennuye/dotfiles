{ lib, ... }:

with lib
{
    services.k3s = {
        enable = true;
        role = "server";
        extraFlags = toString [ "--disable service-lb" ];
    };
}
