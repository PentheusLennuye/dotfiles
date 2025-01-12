# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, ... }:

{


  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Default editor
  environment.variables.EDITOR = "vim";

  # I need my firmware
  nixpkgs.config.allowUnfree = true;
 
  # I also want my emulation station
  programs.gamemode.enable = true;


  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  system.stateVersion = "23.11"; # The original INSTALL version
}
