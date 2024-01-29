# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  users.users.username = {   # Replace username
    isNormalUser = true;
    description = "Firstname Lastname";
    extraGroups = [ "networkmanager" "wheel" "audio" "libvirtd" ];
    shell = pkgs.zsh;   # Remove if using bash
    packages = with pkgs; [];
  };
  security.sudo.extraRules = [{
    users = ["username"];
    commands = [{
      command = "ALL";
      options = ["NOPASSWD"];
    }];
  }];

  # Enable automatic login for the user.
  services.getty.autologinUser = "username";  # replace username. However, it
                                              # might not be cool to have an
                                              # autologin /and/ sudo NOPASSWD
}
