{ config, pkgs, ... }:

{
  imports = [
    ../modules/oryx.nix
    ../modules/printing.nix
    ../modules/sound.nix
  ];
}
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qt6.qtwayland
  ];

  fonts.packages = with pkgs; [
    dina-font
    ipafont         # jp
    kochi-substitute  # jp
    liberation_ttf
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    proggyfonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-lua
      fcitx5-mozc
    ];
  };

  security.polkit.enable = true;

  # HYPRLAND

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.xwayland.enable = true;

  # KDE 6

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.wayland.enable = true;
    displayManager.defaultSession = "plasma";
    xserver.enable = true;
  };
}

