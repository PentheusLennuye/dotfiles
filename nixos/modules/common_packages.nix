# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ansible
    curl
    file
    git
    gnupg
    lsof
    mesa
    openssl
    pciutils
    pstree
    rsync
    tree
    usbutils
    vim
    wget
  ];

  programs.gpg = {
    enable = true;
  };

  programs.zsh.enable = true;
}