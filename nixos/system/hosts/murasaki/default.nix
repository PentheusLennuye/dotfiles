{ ... }:

{
  imports = [
    ./bootloaders.nix
    ./hardware-configuration.nix
    ../../models/lenovo/thinkbook_14s_gen1
    ./networking.nix
    ./hibernation.nix
  ];

  nix = {
    settings = {
      post-build-hook = "/etc/nix/upload-to-cache.sh";
    };
  };
}
