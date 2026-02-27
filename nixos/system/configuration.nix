# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ ... }:

{

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "http://nixoscache.cummings-online.local:5000"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nixoscache.cummings-online.local-1:ibqnK1QZAFpnNyhD++QH4pdmMoaHx5YeZCGyr+I/FhY="
      ];
      trusted-users = [
        "ncu"
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
