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
        source <(kubectl completion zsh)
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
      DF = "$HOME/spaces/tech/infra/dotfiles";
      SRC = "$HOME/spaces/tech/programming/projects";
      GOPATH = "$HOME/.go";
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
      KUBECONFIG = "$HOME/.kube/config";
    };
    shellAliases = {
      hbs="home-manager build switch";
      k="kubectl";
      ls="lsd";
      ll="ls -l";
      la="ls -la";
      ssh="TERM=xterm-256color ssh";
      sns="sudo nixos-rebuild switch";
    };
  };
}

