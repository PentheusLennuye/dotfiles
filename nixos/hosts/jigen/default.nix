{ ... }:

{
  imports = [
    ../common
    ./bootloaders.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./virtualization.nix
  ];
}
