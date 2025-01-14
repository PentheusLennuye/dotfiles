#!/usr/bin/env bash

[ -z {$BU+x} ] && ( echo "Set backup path BU. Exiting." && exit 1 )

rsync -avrt --delete \
  --include=.config \
    --include=.config/joplin-desktop/plugins \
    --include=.config/joplin-desktop/settings.json \
    --exclude=".config/joplin-desktop/*" \
    --exclude=.config/Joplin \
    --exclude=gmc/.config/kwinrc \
    --exclude=gmc/.config/kactivitymanagerdrc \
    --exclude=gmc/.config/kglobalshortcutsrc \
    --exclude=gmc/.config/kxkbrc \
    --exclude=gmc/.config/kwinrulesrc \
    --exclude=gmc/.config/plasma-org.kde.plasma.desktop-appletsrc \
    --exclude=gmc/.config/user-dirs.dirs \
  --include=".gitconfig*" \
  --include=.gnupg \
  --include=.local \
    --include=.local/share \
      --exclude=.local/share/Steam \
    --exclude=".local/*" \
  --include=.ssh \
  --include=.thunderbird \
  --include=.vscode \
  --include=atlas --include=calendar --include=cards --include=extra \
  --include=sources \
    --exclude=iCloud --exclude=iso --exclude=roms --exclude=videos \
  --include=spaces \
    --exclude=sport \
  --exclude="Desktop" --exclude="Downloads" --exclude="tmp" \
  --exclude="archive" --exclude=".*" --exclude="*" \
  $BU/ $HOME
