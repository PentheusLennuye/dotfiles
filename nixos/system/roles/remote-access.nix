{ config, ... }:

{
    services.xrdp = {
        enable = true;
        defaultWindowManager = "Hyprland";
        openFirewall = true;
    };
}
