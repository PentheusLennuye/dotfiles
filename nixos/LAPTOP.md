# Laptops

<!-- markdownlint-disable MD031 -->

Laptops will need additional configuration.

## Hibernate-then-suspend

### Credit

Kudos to <https://www.worldofbs.com/nixos-framework/>

1. Set some variables for ease of use
   ```sh
   HWFILE=hosts/<hostname>/hardware-configuration.nix
2. Get the swap device UUID
   ```sh
   sudo -i
   SWAPDEV=$(grep -A2 swapDevices $HWFILE | grep by-uuid | cut -d\" -f2)
   ```
3. Get the swapfile offset
   ```sh
   OFFSET=$(filefrag -v $SWAPDEV |
     awk '$1=="0:" {print substr($4, 1, length($4)-2)}')
   [ "$OFFSET" = "" ] && OFFSET=0
   ```
4. Add the swap device to the hardware configuration
   ```sh
   PARAMS="[ \"mem_sleep_default=deep\" \"resume_offset=$OFFSET\"]"
   sed -i "/boot.kernelModules/a  boot.resumeDevice = \"${SWAPDEV}\";" $HWFILE
   sed -i "/boot.resumeDevice/a  boot.kernelParams=${PARAMS};" $HWFILE
   ```
5. Append hibernate services to the host configuration
   ```sh
   cat >>hibernation.nix <<EOF
   # Suspend-then-hibernate everywhere
   { config, ... }
   {
     services.logind = {
       lidSwitch = "suspend-then-hibernate";
       extraConfig = ''
         HandlePowerKey=suspend-then-hibernate
         IdleAction=suspend-then-hibernate
         IdleActionSec=2m
       '';
     };
   }
   systemd.sleep.extraConfig = "HibernateDelaySec=1h";
   EOF
   sed -i '/\];/    ./hibernation.nix' hosts/<hostname>/default.nix
   ```
