{ pkgs, ... }:

{
  home.packages = with pkgs; [
    texliveSmall
  ];
}
