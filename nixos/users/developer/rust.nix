{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    buildInputs = [
        pkgs.latest.rustChannels.stable.rust
        pkgs.latest.rustChannels.stable.rust-src
    ];
    RUST_SRC_PATH="${pkgs.latest.rustChannels.stable-rust-src}/lib/rustlib/src/rust/library/";
}
