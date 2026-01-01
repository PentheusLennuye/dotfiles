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

    # Editors and IDE ----------------------------------------
    fd       # find binary for neovim telescope
    neovim
    ripgrep  # grep binary for neovim telescope
    tree-sitter

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
    python312Packages.jedi-language-server
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
