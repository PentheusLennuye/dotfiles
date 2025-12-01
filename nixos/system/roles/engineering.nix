{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad-wayland
    orca-slicer
    xppen_4
  ];
  networking = {
    firewall.allowedTCPPorts = [ 8883 7071 ];
    firewall.allowedUDPPortRanges = [ { from = 15001; to = 15005; } ];
  };
}
