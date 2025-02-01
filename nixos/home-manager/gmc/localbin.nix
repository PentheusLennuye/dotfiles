{ pkgs, config, xdg, ... }:


{
  home.file = {
    ".local/bin/backup_home".source = bin/backup_home;
    ".local/bin/backup_home_small".source = bin/backup_home_small;
    ".local/bin/restore_home".source = bin/restore_home;
    ".local/bin/restore_home_small".source = bin/restore_home_small;
    ".local/bin/sync_vault".source = bin/sync_vault.sh;
  };
}
