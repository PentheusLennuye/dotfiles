{ config, pkgs, lib, ... }:

{
    fileSystems."/mnt/jigen" = {
        device = "server:/jigen-int";
        fsType = "nfs4";
    };
}
