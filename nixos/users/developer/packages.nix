{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # CI/CD
    docker-compose
    git

    # Markdown
    marksman
    markdownlint-cli
    python311Packages.mdformat  # Autoformatter for markdown

    # Python
    poetry
    python3
    python311Packages.jedi-language-server # LSP server
    virtualenv

    # Rust
    cargo
    gcc
    rustc
    rust-analyzer

    # Editors and IDE
    neovim
    vscode
  ];
}
