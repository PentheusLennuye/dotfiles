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
    poetry
    #python3
    #python315Packages.black                # PEP-8
    #python315Packages.cookiecutter         # Templates
    #python315Packages.invoke
    #python315Packages.mdformat             # Autoformatter for markdown
    #python315Packages.pip
    #python315Packages.pipx
    #python315Packages.flake8               # PEP-8
    #python315Packages.jedi-language-server # LSP server
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
}
