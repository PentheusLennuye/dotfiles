{ config, inputs, pkgs, ... }:

let
    # Derivation for wallpapers --------------------------------------------
    background-package = pkgs.stdenvNoCC.mkDerivation {
        name = "background-image";
        src = ./sddm/wallpaper.jpg;
        dontUnpack = true;
        installPhase = ''
          cp $src $out
        '';
    };
    # End derivation --------------------------------------------------------

in
{
  imports = [
    ../modules/gmc-wants.nix
    ../modules/oryx.nix
    ../modules/printing.nix
    ../modules/sound.nix
  ];

  environment.systemPackages = [
    inputs.rose-pine-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.hypridle
    pkgs.hyprpolkitagent
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
    pkgs.elegant-sddm
    pkgs.xwayland
    pkgs.zoom-us
    # See background-package above
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
      [General]
      background = "${background-package}"
    '')
  ];

  fonts.packages = with pkgs; [
    dina-font
    ipafont         # jp
    kochi-substitute  # jp
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    proggyfonts
    nerdfonts.jetbrains-mono
  ];

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-lua
      fcitx5-mozc
    ];
  };

  security.polkit.enable = true;


# ┌───────────────────────────────────────────────────────────────────────────┐
# │                           Display Manager                                 │
# └───────────────────────────────────────────────────────────────────────────┘

  services = {
    displayManager.sddm = {
        enable = true;
        theme = "breeze";
        wayland.enable = true;
    };
    displayManager.defaultSession = "hyprland-uwsm";
    xserver.enable = true;
  };
}


# ┌───────────────────────────────────────────────────────────────────────────┐
# │                               Hyprland                                    │
# └───────────────────────────────────────────────────────────────────────────┘

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.hyprlock = {
    enable = true;
  };
  security.pam.services.hyprlock = {};


# ┌───────────────────────────────────────────────────────────────────────────┐
# │                               KDE6                                        │
# └───────────────────────────────────────────────────────────────────────────┘

  services.desktopManager.plasma6.enable = true;

