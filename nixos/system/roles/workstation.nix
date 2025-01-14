{ config, inputs, pkgs, ... }:

{
  imports = [
    ../modules/gmc-wants.nix
    ../modules/oryx.nix
    ../modules/printing.nix
    ../modules/sound.nix
  ];

  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    pkgs.hypridle
    pkgs.qt6.qtwayland
    pkgs.kdePackages.kaddressbook
    pkgs.kdePackages.kcalc
    pkgs.kdePackages.kde-cli-tools
    pkgs.kdePackages.kdepim-runtime  # Required for kmail
    pkgs.kdePackages.kmahjongg
    pkgs.kdePackages.kmail
    pkgs.kdePackages.kmail-account-wizard
    pkgs.kdePackages.kontact
    pkgs.kdePackages.kpat
    pkgs.kdePackages.qtmultimedia
    pkgs.xwayland
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background=${pkgs.kdePackages.plasma-workspace-wallpapers}/share/wallpapers/MilkyWay/contents/images/5120x2880.png
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

