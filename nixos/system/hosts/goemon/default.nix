{ ... }:

{
  imports = [
    ./bootloaders.nix
    ./hardware-configuration.nix
    ./networking.nix
    ./specific_packages.nix
  ];

  nix = {
    settings = {
      post-build-hook = "/etc/nix/upload-to-cache.sh";
    };
  };
}
