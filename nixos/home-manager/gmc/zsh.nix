{ config, pkgs, ... }:

{
  programs.zsh = {
    dotDir = "${config.xdg.configHome}/zsh";
    enable = true;
    autosuggestion.enable = false;
    initContent = ''
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
      CA = "$HOME/spaces/tech/infra/ca";
      DF = "$HOME/spaces/tech/infra/dotfiles";
      GOPATH = "$HOME/.go";
      KUBECONFIG = "$HOME/.kube/config";
      SAP = "$HOME/spaces/sap/projects/src";
      SSH_ASKPASS = "";
      SRC = "$HOME/spaces/tech/programming/projects";
      RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
    };
    shellAliases = {
      hbs="home-manager build switch";
      k="kubectl";
      ke="kubectl exec";
      ls="lsd";
      ll="ls -l";
      la="ls -la";
      ssh="TERM=xterm-256color ssh";
      vsh="TERM=xterm-256color vagrant ssh";
      sns="sudo nixos-rebuild switch";
      snt="sudo nixos-rebuild test";
    };
  };
}

