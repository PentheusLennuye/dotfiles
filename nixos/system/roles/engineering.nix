{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    orca-slicer
  ];
  networking = {
    firewall.allowedTCPPorts = [ 8883 7071 ];
    firewall.allowedUDPPortRanges = [ { from = 15001; to = 15005; } ];
  };
}
