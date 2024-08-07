# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with lib;
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    curl
    git
    mesa
    vim
    wget
  ];
  programs.zsh.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  
  services.printing = mkIf (config.networking.hostName != "jigen")  {
    enable = true;
  };

}
