{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pstree
    tree
  ];
}
