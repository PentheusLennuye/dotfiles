{ config, pkgs, lib, ... }:

{
    fileSystems."/mnt/lupin" = {
        device = "lupin-int:/fleetwood";
        fsType = "nfs4";
    };
}
