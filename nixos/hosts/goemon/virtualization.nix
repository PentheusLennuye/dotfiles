{ config, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable= true;
}
