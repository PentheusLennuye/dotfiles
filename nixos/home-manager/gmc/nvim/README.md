# NVIM set up

## Haskell Prerequisites

Even if one is not programming in Haskell on the workstation, I want to have at least the Haskell
language server present, lazy-loaded or not, just to keep all machines somewhat within drift.

The prerequisites are found in <https://github.com/mrcjkb/haskell-tools.nvim>.

### Mac OS X

You will need the Xcode Command Line Tools: `xcode-select --install`

#### GHCups-installed Haskell Toolchain 

```sh
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

When prompted, select "D" for the default channel and "N" twice to avoid the bleeding edge, "A"
to append the PATH to the zshrc, "Y" for the language server, and "Y" to have ghcups manage the
Haskell tools.

#### Hoogle Search

```sh
cabal install fast-tags ghci-dap haskell-dap haskell-debug-adapter hoogle
# Go for coffee
echo >> ~/.ghci ':def hoogle \x -> return $ ":!hoogle " ++ x'
```

### NixOS

All the prerequisites are in the dotfiles. 

## First Run

The very first time you run nvim, it will download some LSPs.

### First Run on NixOS

Some LSPs will require compiling so run nvim the first time in its own nix shell.

```sh
nix-shell -p pkg-config openssl
nvim
```

