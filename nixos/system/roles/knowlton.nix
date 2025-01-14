{ config, lib, pkgs, ... }:

{    
  networking.nameservers = [ "192.168.73.31" "192.168.73.32" "8.8.8.8" ];
}
