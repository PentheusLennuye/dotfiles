{ pkgs, ... }:

{
  home.packages = with pkgs; [
    anki                                   # Flashcards, requires QT
    ansible                                # Used for non-Nix VMs
    appimage-run                           # Required for Joplin
    cider                                  # Apple Music for Linux
    dexed                                  # DX7 VST plugin
    firefox
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en_CA-large
    hunspellDicts.es_MX
    hunspellDicts.fr-any
    hyprpaper                              # wallpaper for Hyprland
    joplin-desktop
    kitty                                  # terminal
    libreoffice-qt
    linuxsampler                           # Sample-based synthesizer VST
    minecraft
    pavucontrol                            # PulseAudio control requires GTK
    qsampler                               # GUI for linuxsampler
    qjackctl
    reaper
    rsync
    starship
    surge                                  # synthesizer
    swaynotificationcenter                 # Waybar modules require this
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
  ];
}
