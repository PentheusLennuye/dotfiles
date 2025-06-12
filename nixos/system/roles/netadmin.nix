{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        openldap
    ];

}
