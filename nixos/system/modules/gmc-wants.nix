{ config, pkgs, unstable, ... }:

let
  fastMovingPkgs = with unstable; [
    joplin-desktop                         # Notepad
  ];

  stablePkgs = with pkgs; [
    _1password-gui                         # 1Password password manager
    anki                                   # Flashcards, requires QT
    appimage-run                           # Needed for Cider 2
    calibre                                # eBook software
    canon-cups-ufr2
    dexed                                  # DX7 VST plugin
    digikam
    firefox
    freetube                               # YouTube on chromium
    gimp
    glxinfo                                # Testing glx info
    grim                                   # Wayland image grabber
    handbrake                              # Converts video formats
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en_CA-large
    hunspellDicts.es_MX
    hunspellDicts.fr-any
    hyprpaper                              # wallpaper for Hyprland
    inkscape
    kitty
    obsidian
    onlyoffice-desktopeditors
    pavucontrol                            # PulseAudio control requires GTK
    reaper                                 # DAW
    screenfetch                            # Show off!
    skypeforlinux
    slurp                                  # Hyprland screen selector
    starship
    surge                                  # synthesizer
    swaynotificationcenter                 # Waybar modules require this
    thunderbird
    vistafonts                             # Better fonts for Firefox etc
    vlc
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
    zotero                                 # reference manager
  ];

in
{
  environment.systemPackages = stablePkgs ++ fastMovingPkgs;
}

