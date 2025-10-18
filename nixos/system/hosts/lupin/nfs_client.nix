{ config, pkgs, lib, ... }:

{
    fileSystems."/mnt/jigen" = {
        device = "jigen-int:/export/fleetwood";
        fsType = "nfs4";
    };
}
