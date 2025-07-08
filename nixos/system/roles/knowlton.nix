{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "192.168.73.31" "8.8.8.8" ];
}
