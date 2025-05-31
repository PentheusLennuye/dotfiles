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
    inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
    pkgs.hypridle
    pkgs.hyprpolkitagent
    pkgs.qt6.qtwayland
    pkgs.kdePackages.kcalc
    pkgs.kdePackages.kmahjongg
    pkgs.kdePackages.qtmultimedia
    pkgs.elegant-sddm
    pkgs.texlivePackages.charter
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
    noto-fonts-emoji
    proggyfonts
    nerd-fonts.jetbrains-mono
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
    displayManager.sddm = {
        enable = true;
        theme = "breeze";
        wayland.enable = true;
    };
    displayManager.defaultSession = "hyprland";
    xserver.enable = true;
  };

  services.udev.extraRules = ''
    KERNEL=="uinput",MODE:="0666",OPTIONS+="static_node=uinput"
    SUBSYSTEMS=="usb",ATTRS{idVendor}=="28bd",MODE:="0666"
  '';
}

