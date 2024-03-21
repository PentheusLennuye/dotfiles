{ pkgs, ... }:

{
  home.packages = with pkgs; [
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

    # CI/CD
    docker-compose
    git

    # Editors and IDE
    neovim
    vscode
  ];
}
