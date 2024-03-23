{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible                                # Used for non-Nix VMs
    appimage-run                           # Required for Joplin
    cider                                  # Apple Music for Linux
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
    rsync
    starship
    swaynotificationcenter                 # Waybar modules require this
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
  ];
}
