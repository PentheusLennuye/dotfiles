{ ... }:

{
  imports = [
    ./bootloaders.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./nfs_client.nix
  ];
}
