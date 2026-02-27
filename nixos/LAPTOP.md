# Laptops

<!-- markdownlint-disable MD031 -->

Laptops will need additional configuration.

## Hibernate-then-suspend

### Credit

Kudos to <https://www.worldofbs.com/nixos-framework/>

### Step-by-step

1. Set some variables for ease of use
   ```sh
   HW_FILE=hosts/$(hostname -s)/hardware-configuration.nix
   ```
2. Get the swap device UUID
   ```sh
   sudo -i
   SWAP_DEVICE=$(grep swapDevices $HW_FILE | grep by-label | cut -d'"' -f2)
   ```
3. Get the swap file offset
   ```sh
   OFFSET=$(filefrag -v $SWAP_DEVICE |
     awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
   [ "$OFFSET" = "" ] && OFFSET=0
   ```
4. Add the swap device to the hardware configuration
   ```sh
   PARAMS="[ \"mem_sleep_default=deep\" \"resume_offset=$OFFSET\"]"
   sed -i "/boot.kernelModules/a  boot.resumeDevice = \"${SWAP_DEVICE}\";" $HW_FILE
   sed -i "/boot.resumeDevice/a  boot.kernelParams=${PARAMS};" $HW_FILE
   ```
5. Append hibernate services to the host configuration
   ```sh
   cat >>hibernation.nix <<EOF
   # Suspend-then-hibernate everywhere
   { config, ... }:
   {
     services.logind = {
       lidSwitch = "suspend-then-hibernate";
       extraConfig = ''
         HandlePowerKey=suspend-then-hibernate
         IdleAction=suspend-then-hibernate
         IdleActionSec=2m
       '';
     };
     systemd.sleep.extraConfig = "HibernateDelaySec=1h";
   }
   EOF
   sed -i '/\];/\ \ \ \ ./hibernation.nix' hosts/$(hostname -n)/default.nix
   ```

### All at once

```sh
sudo -i
HW_FILE=hosts/$(hostname -s)/hardware-configuration.nix
SWAP_DEVICE=$(grep swapDevices $HW_FILE | grep by-label | cut -d'"' -f2)
OFFSET=$(filefrag -v $SWAP_DEVICE | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'
[ "$OFFSET" = "" ] && OFFSET=0

PARAMS="[ \"mem_sleep_default=deep\" \"resume_offset=$OFFSET\"]"
sed -i "/boot.kernelModules/a  boot.resumeDevice = \"${SWAP_DEVICE}\";" $HW_FILE
sed -i "/boot.resumeDevice/a  boot.kernelParams=${PARAMS};" $HW_FILE

cat >>hibernation.nix <<EOF
# Suspend-then-hibernate everywhere
{ config, ... }:
{
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      IdleAction=suspend-then-hibernate
      IdleActionSec=2m
    '';
  };
  systemd.sleep.extraConfig = "HibernateDelaySec=1h";
}
EOF

sed -i '/\];/\ \ \ \ ./hibernation.nix' hosts/$(hostname -n)/default.nix
exit
```
