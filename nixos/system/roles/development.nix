{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    # C
    gcc

    # CI/CD
    argocd
    docker-compose
    git
    gh
    pinentry-tty                        # GnuPG password control

    # Documentation and Translation
    enchant
    gettext

    # Editors and IDE
    neovim

    # Shell control
    gnumake

    # Golang
    go
    golangci-lint
    golangci-lint-langserver

    # Haskell
    ghc

    # JavaScript
    nodejs

    # Markdown
    marksman
    markdownlint-cli

    # Python
    cookiecutter
    enchant
    poetry
    python312
    virtualenv

    # Rust
    cargo
    clang
    clippy
    rustc
    rust-analyzer

    # YAML
    jq
    yamllint

  ];

  # Allow Python to use system binaries, such as enchant
  programs.nix-ld.enable = true;
}
