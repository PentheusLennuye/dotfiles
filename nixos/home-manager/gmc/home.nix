{ lib, pkgs, ... }:
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
    ./kitty.nix
    ./starship.nix
    ./zsh.nix
 
    # Desktops
    lib.mkIf (builtins.elem config.networking.hostName [ "goemon" "murasaki" ]) {

    ./hyprland.nix
    ./kde.nix
    ./vlc.nix
    ./vscode.nix
    ./waybar.nix
    ./wofi.nix
}
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

  news = {
    display = "silent";
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
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      templates = "$HOME/Templates";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      publicShare = "$HOME/Share";
      videos = "$HOME/Videos";
    };
  };

}
