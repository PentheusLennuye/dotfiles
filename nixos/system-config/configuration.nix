# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./hyprland.nix
      ./network.nix
      ./opengl.nix
      ./sound.nix
      ./tls.nix
      ./users.nix
    ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;

# Uncomment on sisyphus, which does in fact have a disk with UUID 0ACF-0F7F
#   extraEntries = ''
#     menuentry "Windows" {
#       insmod part_gpt
#       insmod fat
#       insmod search_fs_uuid
#       insmod chain
#       search --fs-uuid --set=root 0ACF-0F7F
#       chainloader /EFI/Microsoft/Boot/bootmgfw.efi
#     }
#   '';
    };
  };

  time.hardwareClockInLocalTime = true;

  # TZ and i8n ---------------------------------------------------------------
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Packages -----------------------------------------------------------------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    brightnessctl
    dconf
    lsof
    killall
    mako
    polkit
    swaylock
    swayidle
    wget
    vim
    zsh
  ];
 
  # Programs, Services, Virtualization enabled -------------------------------

  programs.dconf.enable = true;
  programs.sway.enable = true;
  programs.zsh.enable = true;
  programs.virt-manager.enable = true;
  services.openssh.enable = true;


  # Virtualization ------------------------------------------------------------

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # System lock ----------------------------------------------------------------

  security.pam.services.swaylock = {};

  # State Version ------------------------------------------------------------
  system.stateVersion = "23.11"; # Did you read the comment?
}

