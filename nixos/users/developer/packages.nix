{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Python
    poetry
    python3
    virtualenv

    # Rust
    cargo
    gcc
    rustc

    # CI/CD
    docker-compose
    git

    # Editors and IDE
    neovim
    vscode
  ];
}
