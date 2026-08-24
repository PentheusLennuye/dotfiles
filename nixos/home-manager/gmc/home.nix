{ pkgs, ... }:
let
  homeDir = "/home/gmc";
in
{
  imports = [
    ./localbin.nix
    ./misc.nix
    ./neovim.nix
    ./vim.nix
    ./kitty.nix
    ./starship.nix
    ./zsh.nix
  ];
  # Home =====================================================================
  home = {
    homeDirectory = homeDir;
    sessionPath = [ "${homeDir}/.local/bin" ];
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
