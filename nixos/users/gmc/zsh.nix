{ pkgs, ... }:

{
  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    autosuggestion.enable = false;
    initExtra = ''
        bindkey "$terminfo[kcuu1]" history-substring-search-up
        bindkey "$terminfo[kcud1]" history-substring-search-down
        export LIBVIRT_DEFAULT_URI="qemu:///system";
    '';
    plugins = [{
      name = "zsh-history-substring-search";
      src = pkgs.fetchFromGitHub {
        owner = "zsh-users";
        repo = "zsh-history-substring-search";
        rev = "v1.1.0";
        sha256 = "GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
      };
    }];
    sessionVariables = {
      SRC = "$HOME/1_personal/spaces/tech/projects";
      GOPATH = "$HOME/.go";
    };
    shellAliases = {
      hbs="home-manager build switch";
      ls="ls --color";
      ll="ls -l";
      la="ls -la";
      ssh="TERM=xterm-256color ssh";
      sns="sudo nixos-rebuild switch";
    };
  };
}

