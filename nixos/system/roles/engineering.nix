{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad-wayland
    orca-slicer
  ];
  networking = {
    firewall.allowedTCPPorts = [ 8883 7071 ];
    firewall.allowedUDPPortRanges = [ { from = 15001; to = 15005; } ];
  };
  programs.xppen= {
    enable = true;
    package = pkgs.xppen_4;
  };
}
