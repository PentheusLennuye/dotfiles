# to /etc/nixos/configuration.nix instead.
{ ... }:
{
  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
  boot.resumeDevice = "/dev/disk/by-label/swap";
}
