{ config, pkgs, lib, ... }:

let 
  role = config.role;
in

with lib;
{
  home = mkIf role.workstation {
    packages = with pkgs; [
      _1password-gui                         # 1Password password manager
      anki                                   # Flashcards, requires QT
      appimage-run                           # Required for Joplin
      cider                                  # Apple Music for Linux
      dexed                                  # DX7 VST plugin
      digikam
      firefox
      freetube                               # YouTube on chromium
      gimp
      glxinfo                                # Testing glx info
      handbrake                              # Converts video formats
      hunspell
      hunspellDicts.de-de
      hunspellDicts.en_CA-large
      hunspellDicts.es_MX
      hunspellDicts.fr-any
      hyprpaper                              # wallpaper for Hyprland
      inkscape
      joplin-desktop
      kitty                                  # terminal
      libreoffice-qt
      pavucontrol                            # PulseAudio control requires GTK
      pinentry-qt                            # GnuPG password control
      reaper                                 # DAW
      skypeforlinux
      starship
      surge                                  # synthesizer
      swaynotificationcenter                 # Waybar modules require this
      sweethome3d.application                # Floor planning, temp.
      sweethome3d.furniture-editor
      sweethome3d.textures-editor
      vistafonts                             # Better fonts for Firefox etc
      vlc
      waybar                                 # task/toolbar for Hyprland
      wofi                                   # program selector for Hyprland
    ];
  };
  services.gpg-agent = mkIf role.workstation {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };
  programs.kitty = mkIf role.workstation {
    enable = true;
    settings = {
      shell = "zsh";
      font_family = "JetBrains mono";
      font_size = "11.5";
      background_opacity = "0.7";
    };
  };
}
