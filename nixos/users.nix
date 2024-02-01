{ config, pkgs, ... }:

{
  users.users.gmc= {
    isNormalUser = true;
    description = "George Cummings";
    extraGroups = [ "networkmanager" "wheel" "audio" "libvirtd" "docker" ];
    shell = pkgs.zsh;   # Remove if using bash
    packages = with pkgs; [];
  };
  security.sudo.extraRules = [{
    users = ["gmc"];
    commands = [{
      command = "ALL";
      options = ["NOPASSWD"];
    }];
  }];

  # Enable automatic login for the user.
  services.getty.autologinUser = "gmc"; 
}
