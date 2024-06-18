{ pkgs, ... }:

{
  programs.zsh = {
    initExtra = "source <(kubectl completion zsh)";
    shellAliases = {
      k="kubectl";
    };
  };
}
