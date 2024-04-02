{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible                                # Used for non-Nix VMs
    appimage-run                           # Required for Joplin
    cider                                  # Apple Music for Linux
    dexed                                  # Yamaha DX-7 VST3i
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
    reaper                                 # Audio workstation
    rsync
    starship
    surge                                  # Analog Synthesizer VST3i
    swaynotificationcenter                 # Waybar modules require this
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
  ];
}
