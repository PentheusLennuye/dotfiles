#!/usr/bin/env bash

LOCAL=~/Documents/pkm
ORIGIN=/mnt/nfs/lupin/home/gmc/pkm

rsync -avrt ${ORIGIN}/* ${LOCAL}/ --exclude .obsidian --exclude .trash

