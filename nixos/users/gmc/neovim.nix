{ pkgs, config, ... }:

{
  home.file.".local/share/nvim/site/autoload/plug.vim".source = nvim/plug.vim;
  home.file.".config/nvim/init.lua".source = nvim/init.lua;
  home.file.".config/nvim/lua/vars.lua".source = nvim/lua/vars.lua;
  home.file.".config/nvim/lua/opts.lua".source = nvim/lua/opts.lua;
  home.file.".config/nvim/lua/keys.lua".source = nvim/lua/keys.lua;
  home.file.".config/nvim/lua/plug.lua".source = nvim/lua/plug.lua;
  home.file.".config/nvim/lua/ide.lua".source = nvim/lua/ide.lua;
}
