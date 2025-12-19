{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    freecad-wayland
    #bambu-studio
    orca-slicer
  ];
  networking = {
    firewall = {
        allowedTCPPorts = [ 322 990 6000 8883 7071 ];
        allowedTCPPortRanges = [ { from = 50000; to = 50100; } ]; 
        allowedUDPPorts = [ 1990 2021 ];
        allowedUDPPortRanges = [
            { from = 123; to = 123; }
            { from = 15001; to = 15005; }
        ];
    };
  };
  programs.xppen= {
    enable = true;
    package = pkgs.xppen_4;
  };
}



