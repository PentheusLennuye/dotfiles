# Suspend-then-hibernate everywhere
services.logind = {
  lidSwitch = "suspend-then-hibernate";
  extraConfig = ''
    HandlePowerKey=suspend-then-hibernate
    IdleAction=suspend-then-hibernate
    IdleActionSec=2m
  '';
};
systemd.sleep.extraConfig = "HibernateDelaySec=1h";
