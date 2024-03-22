{ config, pkgs, ... }:

{
  users.users.gmc= {
    isNormalUser = true;
    description = "George Cummings";
    extraGroups = [ "networkmanager" "wheel" "audio" "libvirtd" "docker" ];
    shell = pkgs.bash;
    packages = with pkgs; [];
  };
  security.sudo.extraRules = [{
    users = ["gmc"];
    commands = [{
      command = "NOPASSWD: ALL";
    }];
  }];
}
