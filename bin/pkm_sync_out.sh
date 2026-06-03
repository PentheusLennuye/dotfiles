#!/usr/bin/env bash

LOCAL=~/Documents/pkm
ORIGIN=/mnt/nfs/lupin/home/gmc/pkm

rsync -avrt ${LOCAL}/* ${ORIGIN}/ --exclude .obsidian --exclude .trash

