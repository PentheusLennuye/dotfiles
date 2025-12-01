# Suspend-then-hibernate everywhere
{ config, ... }:
{
  services.logind = {
    settings.Login = {
      HandleLidSwitch = "suspend-then-hibernate";
      HandlePowerKey = "suspend-then-hibernate";
      IdleAction = "suspend-then-hibernate";
      IdleActionSec = "2m";
    };
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";
}
