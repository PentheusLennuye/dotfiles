{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ansible
    file
    gnupg
    openssl
    pciutils
    pstree
    rsync
    tree
    usbutils
  ];
  programs.gpg = {
    enable = true;
  };
}
