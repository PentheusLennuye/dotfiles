{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anki                                   # Flashcards, requires QT
    ansible                                # Used for non-Nix VMs
    appimage-run                           # Required for Joplin
    cider                                  # Apple Music for Linux
    corefonts                              # Better fonts for Firefox etc
    dexed                                  # DX7 VST plugin
    firefox
    freetube                               # YouTube on chromium
    glxinfo                                # Testing glx info
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en_CA-large
    hunspellDicts.es_MX
    hunspellDicts.fr-any
    hyprpaper                              # wallpaper for Hyprland
    joplin-desktop
    kitty                                  # terminal
    libreoffice-qt
    minecraft
    musescore                              # WYSIWYG music notation w/ Lilypond
    pavucontrol                            # PulseAudio control requires GTK
    reaper                                 # DAW
    rsync
    starship
    surge                                  # synthesizer
    swaynotificationcenter                 # Waybar modules require this
    vistafonts                             # Better fonts for Firefox etc
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
  ];
}
