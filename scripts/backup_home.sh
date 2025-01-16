#!/usr/bin/env bash

[ -z {$BU+x} ] && ( echo "Set backup path BU. Exiting." && exit 1 )

rsync -avrt --delete \
  --include=.config \
    --include=.config/joplin-desktop/plugins \
    --include=.config/joplin-desktop/settings.json \
    --exclude=".config/joplin-desktop/*" \
    --exclude=.config/Cider \
    --exclude=.config/Joplin \
    --exclude=.config/kwinrc --exclude=.config/kactivitymanagerdrc \
    --exclude=.config/kglobalshortcutsrc --exclude=.config/kxkbrc \
    --exclude=.config/kwinrulesrc \
    --exclude=.config/plasma-org.kde.plasma.desktop-appletsrc \
    --exclude=.config/user-dirs.dirs \
  --include=".gitconfig*" \
  --include=.gnupg \
    --exclude=.gnupg/gpg-agent.conf --exclude=.gnupg/gpg.conf \
    --exclude=.gnupg/scdaemon.conf \
  --include=.local \
    --include=.local/share \
      --exclude=".local/share/baloo/*" \
    --exclude=".local/*" \
  --include=.minecraft \
  --include=.ssh \
  --include=.thunderbird \
  --include=.vscode \
  --include=atlas \
  --include=calendar \
  --include=cards \
  --include=extra \
  --include=sources \
  --include=spaces \
  --include=atlas \
    --include=atlas/**/.* \
  --include=calendar \
    --include=calendar/**/.* \
  --include=cards \
    --include=cards/**/.* \
  --include=extra \
    --include=extra/**/.* \
  --include=sources \
    --exclude=sources/iso \
    --include=sources/**/.* \
  --include=spaces \
    --include=sources/**/.* \
  --exclude=Desktop \
  --exclude=Downloads \
  --exclude="tmp" \
  --exclude=".*" \
  $HOME/ $BU
