#!/usr/bin/env bash
rsync -avrt --delete --delete-excluded \
  --include=.config \
    --include=gmc/.config/joplin-desktop/plugins \
    --include=gmc/.config/joplin-desktop/settings.json \
    --exclude="gmc/.config/joplin-desktop/*" \
    --exclude=gmc/.config/Joplin \
    --exclude=gmc/.config/kwinrc \
    --exclude=gmc/.config/kactivitymanagerdrc \
    --exclude=gmc/.config/kglobalshortcutsrc \
    --exclude=gmc/.config/kxkbrc \
    --exclude=gmc/.config/kwinrulesrc \
    --exclude=gmc/.config/plasma-org.kde.plasma.desktop-appletsrc \
  --include="gmc/.gitconfig*" \
  --include=gmc/.gnupg \
  --include=gmc/.local \
    --include=gmc/.local/share \
    --exclude="gmc/.local/*" \
  --include=gmc/.ssh \
  --include=gmc/0_work --include=/home/gmc/.minecraft --include=/home/gmc/.vscode \
  --include=gmc/1_personal \
  --exclude="gmc/Desktop" --exclude="gmc/Downloads" --exclude="gmc/.*" \
  /home/gmc /srv/backup
