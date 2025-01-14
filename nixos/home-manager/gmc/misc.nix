{ pkgs, config, ... }:

{
  home.file.".config/user-dirs.dir".source = misc/user-dirs.dirs;
}
