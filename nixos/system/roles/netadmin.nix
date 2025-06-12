{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        openldap
    ];

#    users.ldap = {
#        base = "O=Cummings Online";
#        enable = true;
#        server = "ldap://ldap.cummings-online.local";
#    };
}
