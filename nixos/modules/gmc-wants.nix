{ config, pkgs, unstable, ... }:

let
  fastMovingPkgs = with unstable; [
    cider-2                                # Apple Music
    joplin-desktop                         # Notepad
  ];

  stablePkgs = with pkgs; [
    _1password-gui                         # 1Password password manager
    anki                                   # Flashcards, requires QT
    appimage-run                           # Needed for Cider 2
    canon-cups-ufr2
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
    kitty
    libreoffice-qt
    lsd                                    # ls with extras
    pavucontrol                            # PulseAudio control requires GTK
    reaper                                 # DAW
    skypeforlinux
    starship
    surge                                  # synthesizer
    swaynotificationcenter                 # Waybar modules require this
    vistafonts                             # Better fonts for Firefox etc
    vlc
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
  ];

in
{
  environment.systemPackages = stablePkgs ++ fastMovingPkgs;
}

