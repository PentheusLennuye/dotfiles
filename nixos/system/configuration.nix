# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

{

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "http://nixoscache.cummings-online.local:5000"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nixoscache.cummings-online.local-1:HD6ObbUL2CpTGl6xcyFSPcdZrWpLAVA+12TEQCypbAY="
      ];
    };
  };

  # Default editor
  environment.variables.EDITOR = "vim";

  # I need my firmware
  nixpkgs.config = {
    allowUnfree = true;
  };
 
  # I also want my emulation station
  programs.gamemode.enable = true;


  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  system.stateVersion = "23.11"; # The original INSTALL version
}
