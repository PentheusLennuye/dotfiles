{ config, pkgs, lib, ... }:

{
    fileSystems."/mnt/lupin" = {
        device = "jigen-int:/export/fleetwood";
        fsType = "nfs4";
    };
}
