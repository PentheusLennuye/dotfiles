# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    ansible
    cryptsetup # for backups to encrypted drives
    curl
    dmidecode
    file
    fwupd
    fwupd-efi
    git
    gnupg
    libnfs
    lsd # ls +
    lsof
    lshw
    mesa
    nfs-utils
    openssl
    pciutils
    pstree
    rsync
    tree
    unzip
    usbutils
    vim
    wget
    tmux
    zip
  ];

  programs.zsh.enable = true;
}
