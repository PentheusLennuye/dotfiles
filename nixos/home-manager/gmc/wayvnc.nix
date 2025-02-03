{ pkgs, lib, config, ... }:

let
  lconfig = ".config/wayvnc";
in
{
  home.file."${lconfig}/config".source = wayvnc/config;
}
