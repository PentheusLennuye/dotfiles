{ pkgs, config, xdg, ... }:


{
  home.file = {
    ".local/bin/backup".source = bin/backup;
    ".local/bin/restore".source = bin/restore;
  };
}
