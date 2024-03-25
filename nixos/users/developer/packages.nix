{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # CI/CD
    docker-compose
    git

    # Editors and IDE
    neovim
    vscode

    # Markdown
    marksman
    markdownlint-cli
    python311Packages.mdformat  # Autoformatter for markdown

    # Python
    poetry
    python3
    python311Packages.black                # PEP-8
    python311Packages.flake8               # PEP-8
    python311Packages.jedi-language-server # LSP server
    virtualenv

    # Rust
    cargo
    gcc
    rustc
    rust-analyzer

    # YAML
    yamllint

  ];
}
