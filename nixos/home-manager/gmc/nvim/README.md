# NVIM set up

The very first time you run nvim, it will download some LSPs. Some will require compiling so run
nvim the first time in its own nix shell.

```sh
nix-shell -p pkg-config openssl
nvim
```

