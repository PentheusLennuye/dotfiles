#!/usr/bin/env bash
# patch.sh puts nixos system in /etc/nixos and home-manager/gmc in
# ~/.config/home-manager
#
# It runs NEITHER sudo nixos-rebuild switch NOR home-manager build switch

NIXOS_SRC=${HOME}/1_personal/spaces/tech/projects/dotfiles/nixos

sudo rsync -avrt ${NIXOS_SRC}/system/ /etc/nixos
rsync -avrt ${NIXOS_SRC}/home-manager/${USER}/ ${HOME}/.config/home-manager

