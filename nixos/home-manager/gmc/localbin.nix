{ pkgs, config, xdg, ... }:


{
  home.file = {
    ".local/bin/backup_home".source = bin/backup;
    ".local/bin/backup_home_small".source = bin/backup;
    ".local/bin/restore_home".source = bin/restore;
    ".local/bin/restore_home_small".source = bin/restore;
  };
}
