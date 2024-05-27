{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password-gui                         # 1Password password manager
    anki                                   # Flashcards, requires QT
    ansible                                # Used for non-Nix VMs
    appimage-run                           # Required for Joplin
    cider                                  # Apple Music for Linux
    dexed                                  # DX7 VST plugin
    digikam
    firefox
    freetube                               # YouTube on chromium
    gimp
    glxinfo                                # Testing glx info
    hunspell
    hunspellDicts.de-de
    hunspellDicts.en_CA-large
    hunspellDicts.es_MX
    hunspellDicts.fr-any
    hyprpaper                              # wallpaper for Hyprland
    gnupg
    inkscape
    joplin-desktop
    kitty                                  # terminal
    libreoffice-qt
    musescore                              # WYSIWYG music notation w/ Lilypond
    pavucontrol                            # PulseAudio control requires GTK
    pinentry-qt                            # GnuPG password control
    reaper                                 # DAW
    rsync
    skypeforlinux
    starship
    surge                                  # synthesizer
    swaynotificationcenter                 # Waybar modules require this
    vistafonts                             # Better fonts for Firefox etc
    waybar                                 # task/toolbar for Hyprland
    wofi                                   # program selector for Hyprland
  ];

  programs.gpg = {
    enable = true;
  };
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };
}
