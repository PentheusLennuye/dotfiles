{ config, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    _1password-gui                         # 1Password password manager
    anki                                   # Flashcards, requires QT
    cider                                  # Apple Music for Linux
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
    unstable.joplin-desktop
    libreoffice-qt
    pavucontrol                            # PulseAudio control requires GTK
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

  programs.kitty = {
    enable = true;
    settings = {
      shell = "zsh";
      font_family = "JetBrains mono";
      font_size = "11.5";
      background_opacity = "0.7";
    };
  };
}
