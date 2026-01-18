# XKB Keyboard Layout Instructions

## A. NixOS

The configuration is already done for you. See `nixos/system/modules/xkb.nix`.

## B. Other Distributions

### B.1 Local (User) Configuration

```sh
mkdir -p $XDG_CONFIG_HOME/xkb/{rules,symbols}
cp rules/evdev.xml $XDG_CONFIG_HOME/xkb/rules
cp symbols/* $XDG_CONFIG_HOME/xkb/symbols
```

### B.2 System Configuration

Replace `/etc/X11/xkb/rules/evdev.xml` with rules/evdev.xml.

```sh
sudo cp rules/evdev.xml /etc/X11/xkb/rules/evdev.xml
sudo cp symbols/* /etc/X11/xkb/symbols
```
