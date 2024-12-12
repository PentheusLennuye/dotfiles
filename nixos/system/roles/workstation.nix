{ config, pkgs, ... }:

{
  imports = [
    ../modules/gmc-wants.nix
    ../modules/oryx.nix
    ../modules/printing.nix
    ../modules/sound.nix
  ];

  environment.systemPackages = with pkgs; [
    hypridle
    qt6.qtwayland
    kdePackages.kaddressbook
    kdePackages.kcalc
    kdePackages.kde-cli-tools
    kdePackages.kdepim-runtime  # Required for kmail
    kdePackages.kmahjongg
    kdePackages.kmail
    kdePackages.kmail-account-wizard
    kdePackages.kontact
    kdePackages.kpat
    kdePackages.qtmultimedia
    xwayland
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${kdePackages.plasma-workspace-wallpapers}/share/wallpapers/MilkyWay/contents/images/5120x2880.png
    '')
  ];

  fonts.packages = with pkgs; [
    dina-font
    ipafont         # jp
    kochi-substitute  # jp
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
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
  programs.hyprlock = {
    enable = true;
  };
  security.pam.services.hyprlock = {};

  # KDE 6

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.defaultSession = "plasma";
    xserver.enable = true;
  };
}

