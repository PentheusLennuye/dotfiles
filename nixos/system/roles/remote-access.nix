{ config, ... }:

{
    services.xrdp = {
        enable = true;
        defaultWindowManager = "Hyprland -c ~/.config/hypr/hyprland-headless.conf";
        openFirewall = true;
    };
}
