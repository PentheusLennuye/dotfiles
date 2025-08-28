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
    python3
    python311Packages.black                # PEP-8
    python311Packages.cookiecutter         # Templates
    python311Packages.invoke
    python311Packages.mdformat             # Autoformatter for markdown
    python311Packages.pip
    python311Packages.pipx
    python311Packages.flake8               # PEP-8
    python311Packages.jedi-language-server # LSP server
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
