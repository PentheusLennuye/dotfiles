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
    pinentry-tty # GnuPG password control

    # Documentation and Translation
    enchant
    gettext

    # Editors and IDE ----------------------------------------
    codebook # spellchecker for code, more advanced than cSpell
    fd # find binary for neovim telescope
    lazygit # integrate neovim with git
    neovim
    ripgrep # grep binary for neovim telescope
    tree-sitter

    # Shell control
    gnumake

    # Golang
    go
    golangci-lint
    golangci-lint-langserver

    # Haskell
    cabal-install
    ghc
    haskellPackages.fast-tags
    haskellPackages.ghci-dap
    haskellPackages.haskell-dap
    haskellPackages.haskell-debug-adapter
    haskellPackages.haskell-language-server
    haskellPackages.stack
    haskellPackages.hoogle

    # JavaScript
    nodejs

    # Markdown
    marksman
    markdownlint-cli

    # Nix
    nixd
    nixfmt

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
