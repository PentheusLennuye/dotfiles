# Suspend-then-hibernate everywhere
{ config, ... }:
{
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    settings.Login = {
      HandlePowerKey = "suspend-then-hibernate";
      IdleAction = "suspend-then-hibernate";
      IdleActionSec = "2m";
    };
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";
}
