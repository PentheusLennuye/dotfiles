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
    mesa-demos                             # Testing glx info
    openpomodoro-cli
    grim                                   # Wayland image grabber
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en_CA-large
    hunspellDicts.es_MX
    hunspellDicts.fr-any
    hyprpaper                              # wallpaper for Hyprland
    inkscape
    keymapp                                # flashing onyx keyboards
    kitty
    krita                                  # Painting app
    obsidian
    onlyoffice-desktopeditors
    pavucontrol                            # PulseAudio control requires GTK
    reaper                                 # DAW
    screenfetch                            # Show off!
    slurp                                  # Hyprland screen selector
    starship
    surge                                  # synthesizer
    swaynotificationcenter                 # Waybar modules require this
    thunderbird
    vista-fonts                             # Better fonts for Firefox etc
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
    zotero                                 # reference manager
  ];

in
{
  environment.systemPackages = stablePkgs ++ fastMovingPkgs;
}

