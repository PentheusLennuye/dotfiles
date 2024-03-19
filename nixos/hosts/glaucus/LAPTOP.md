# Laptops

Laptops will need additional configuration.

## Hibernate-then-suspend

### Credit

Kudos to <https://www.worldofbs.com/nixos-framework/>

### Get the swap device UUID:
```sh
sudo -i
RESUMEDEV=$(grep -A2 swapDevices /etc/nixos/hardware-configuration.nix \
  | grep by-uuid | cut -d\" -f2)
```

### Get the swapfile offset

```sh
OFFSET=$(filefrag -v $RESUMEDEV \
 | awk '$1=="0:" {print substr($4, 1, length($4)-2)}')
["$OFFSET" == ""] && OFFSET=0
```

### Add the swap device to the hardware configuration

```sh
echo "  boot.resumeDevice = \"$RESUMEDEV\";" >> /etc/nixos/hardware-configuration.nix
echo "  boot.kernelParams = [ \"mem_sleep_default=deep\" \"resume_offset=$OFFSET\"];" >> /etc/nixos/hardware-configuration.nix

vi /etc/nixos/hardware-configuration.nix  # Readjust to ensure the config is within the braces
```

### Append hibernate services to configuration

```sh
sudo vi /etc/nixos/configuration.nix

...

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
```

