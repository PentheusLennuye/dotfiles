{ lib, ... }:

with lib
{
    services.k3s = {
        enable = true;
        role = "server";
        extraFalgs = toString [ "--disable service-lb" ]
    };
}
