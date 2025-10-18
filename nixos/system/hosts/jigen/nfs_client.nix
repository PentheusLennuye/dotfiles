{ config, pkgs, lib, ... }:

{
    fileSystems."/mnt/lupin" = {
        device = "server:/lupin-int";
        fsType = "nfs4";
    };
}
