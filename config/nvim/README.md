# NVIM set up

The directory structure supports multiple languages and formats. Many of the language-server
protocol services require some system prerequisites. If using Nix as the package manager, all
system packages are already configured.

## A. Operating Systems

### A.1 NixOS

#### A.1.1 First Run

The very first time you run nvim, it will download some LSPs that require compiling. Being NixOS,
some libraries are not in the directories expected by the Makefiles. Use the following sequence:

```sh
nix-shell -p pkg-config openssl
nvim  # wait. You may follow the installation of LSPs with the command `:Mason`.
```

### B.1 Other Operating Systems

If using MacOS, you will need the Xcode Command Line Tools: `xcode-select --install`

#### B.1.1 Haskell

The prerequisites are found in <https://github.com/mrcjkb/haskell-tools.nvim>.

Once any system packages are installed, use Cabal to install the nvim requirements:

```sh
cabal update
cabal install fast-tags ghci-dap haskell-dap haskell-debug-adapter hoogle
# Go for coffee
echo >> ~/.ghci ':def hoogle \x -> return $ ":!hoogle " ++ x'
```
