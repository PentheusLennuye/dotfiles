{ pkgs, ... }:
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
    homeDirectory = "/home/gmc";
    sessionPath = [ "/home/gmc/.local/bin" ];
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
      settings = {
        shell = "zsh";
        font_family = "JetBrains mono";
        font_size = "11.5";
        background_opacity = "0.7";
      };
    };
  };

  # Services =================================================================
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentry.package = pkgs.pinentry-tty;
  };

}
