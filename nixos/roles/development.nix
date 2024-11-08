{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # CI/CD
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

    # JavaScript
    nodejs

    # Markdown
    marksman
    markdownlint-cli

    # Python
    poetry
    python3
    python311Packages.black                # PEP-8
    python311Packages.invoke
    python311Packages.mdformat             # Autoformatter for markdown
    python311Packages.pip
    python311Packages.pipx
    python311Packages.flake8               # PEP-8
    python311Packages.jedi-language-server # LSP server
    virtualenv

    # Rust
    cargo
    clippy
    gcc
    rustc
    rust-analyzer

    # YAML
    jq
    yamllint

  ];
}
