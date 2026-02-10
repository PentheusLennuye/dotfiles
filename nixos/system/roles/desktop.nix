{ ... }:

{
  imports = [
    ../modules/xkb.nix
    ./workstation.nix
  ];

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      settings = {
        Theme = {
          EnableAvatars = true;
          FacesDir = "/etc/sddm/icons";
        };
      };
      theme = "breeze";
      wayland.enable = true;
    };
    displayManager.defaultSession = "hyprland-uwsm";
    power-profiles-daemon.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "gmc";
        options = "caps:none";
      };
    };
    udev.extraRules = ''
      KERNEL=="uinput",MODE:="0666",OPTIONS+="static_node=uinput"
      SUBSYSTEMS=="usb",ATTRS{idVendor}=="28bd",MODE:="0666"
    '';
  };
}
