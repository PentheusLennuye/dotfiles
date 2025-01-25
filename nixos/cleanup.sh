#!/usr/bin/env bash
sudo nix-collect-garbage -d &&
    nix-collect-garbage -d && 
    sudo /run/current-system/bin/switch-to-configuration boot
home-manager expire-generations "-7 days"
