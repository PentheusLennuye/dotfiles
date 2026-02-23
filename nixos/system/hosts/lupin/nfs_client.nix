{ ... }:

{
  fileSystems."/mnt/jigen" = {
    device = "jigen-int:/fleetwood";
    fsType = "nfs4";
  };
}
