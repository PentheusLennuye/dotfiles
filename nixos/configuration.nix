# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hyprland.nix
      ./network.nix
      ./tls.nix
      ./users.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # PulseAudio
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.support32Bit = true;
  sound.enable = true;

  # TZ and i8n
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Packages -----------------------------------------------------------------
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
    hyprpaper     # wallpaper for Hyprland
    lsof
    killall
    kitty
    python3
    starship
    vim
    vscode
    waybar        # task/toolbar for Hyprland
    wget
    wofi          # program selector for Hyprland
    zsh
  ];

  # Programs, Services, Virtualization enabled -------------------------------

  programs.zsh.enable = true;
  programs.virt-manager.enable = true;
  services.openssh.enable = true;
  virtualisation.libvirtd.enable = true;

  # Security -----------------------------------------------------------------

  security.polkit.enable = true;   # Required for Hyprland, IIRC

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
