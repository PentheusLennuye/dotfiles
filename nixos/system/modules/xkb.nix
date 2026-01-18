{ pkgs, lib, ... }:
let
  xkbGmc = pkgs.lib.cleanSourceWith {
    filter = path: type: path == ./xkb/symbols/gmc || path == ./xkb/rules/evdev.xml;
    src = ./xkb;
  };
in
{
  environment.etc."X11/xkb/symbols/gmc".source = xkbGmc + "/symbols/gmc";
  environment.etc."X11/xkb/rules/evdev.xml".source = lib.mkForce (xkbGmc + "/rules/evdev.xml");
}
