{ pkgs, ... }:

{
  home.packages = with pkgs; [
    texliveMedium
    pandoc
  ];
}
