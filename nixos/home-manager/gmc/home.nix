{ pkgs, ... }:
let
  homeDir = "/home/gmc";
in
{
  imports = [
    # All
    ./localbin.nix
    ./misc.nix
    ./neovim.nix
    ./vim.nix

    # Desktops
    ./hyprland.nix
    ./kde.nix
    ./starship.nix
    ./vlc.nix
    ./vscode.nix
    ./waybar.nix
    ./wofi.nix
    ./zsh.nix
  ];

  # Home =====================================================================
  home = {
    homeDirectory = homeDir;
    sessionPath = [ "${homeDir}/.local/bin" ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1"; # Wayland on Chromium etc
      WLR_NO_HARDWARE_CURSORS = "1"; # Hyprland cursor
      HYPRCURSOR_SIZE = "24";
      HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    };
    stateVersion = "23.11";
    username = "gmc";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Programs =================================================================

  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    kitty = {
      enable = true;
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
        "ctrl+v" = "paste_from_clipboard";
      };
      settings = {
        background_opacity = "0.7";
        font_family = "JetBrains mono";
        font_size = "11.5";
        shell = "zsh";
      };
    };
  };

  # Services =================================================================
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-tty;
  };

  # XDG ──────────────────────────────────────────────────────────────────────

  xdg = {
    cacheHome = "${homeDir}/.cache";
    configHome = "${homeDir}/.config";
    dataHome = "${homeDir}/.local/share";
    stateHome = "${homeDir}/.local/state";
    userDirs = {
      createDirectories = true;
      enable = true;
      desktop = "$HOME/.desktop";
      documents = "$HOME/";
      download = "$HOME/extra/downloads";
      templates = "$HOME/extra/templates";
      music = "$HOME/extra/music";
      pictures = "$HOME/extra/pictures";
      videos = "$HOME/extra/videos";
    };
  };

}
