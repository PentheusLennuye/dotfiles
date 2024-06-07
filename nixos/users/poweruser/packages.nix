{ pkgs, ... }:

{
  home.packages = with pkgs; [
    file
    pciutils
    pstree
    tree
    usbutils
  ];
}
