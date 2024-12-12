{ pkgs, config, ... }:

{
  home.file.".config/wofi/wofi.conf".source = wofi/wofi.conf;
  home.file.".config/wofi/wofi.css".source = wofi/wofi.css;
}
