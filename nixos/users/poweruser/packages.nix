{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pciutils
    pstree
    tree
    usbutils
  ];
}
