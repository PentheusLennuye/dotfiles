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

As root,

1. Copy `rules/evdev_snippet` into the clipboard
2. Edit `/usr/share/X11/xkb/rules/evdev.xml` and insert the contents of the clipboard to the bottom
   of the `<layoutList>` element.

The "GMC" layouts are now available to X and Waylay. KDE and Gnome may need additional steps.
