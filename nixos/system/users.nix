{ config, pkgs, ... }:

{
  users.groups.family = {
    gid = 3000;
  };
  users.users.gmc = {
    isNormalUser = true;
    description = "George Cummings";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "libvirtd"
      "docker"
      "video"
      "input"
      "dialout"
      "cdrom"
      "gamemode"
    ];
    shell = pkgs.zsh;
  };
  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
  ];
  security.sudo.extraRules = [
    {
      users = [ "gmc" ];
      commands = [
        {
          command = "NOPASSWD: ALL";
        }
      ];
    }
  ];
}
