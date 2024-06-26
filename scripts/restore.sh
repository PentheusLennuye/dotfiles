#!/usr/bin/env bash
rsync -avrt --delete \
  --include=.config \
    --include=gmc/.config/joplin-desktop/plugins \
    --include=gmc/.config/joplin-desktop/settings.json \
    --exclude="gmc/.config/joplin-desktop/*" \
    --exclude=gmc/.config/Joplin \
  --include="gmc/.gitconfig*" \
  --include=gmc/.gnupg \
  --include=gmc/.local \
    --include=gmc/.local/share \
    --exclude="gmc/.local/*" \
  --include=gmc/.ssh \
  --include=gmc/0_work --include=/home/gmc/.minecraft --include=/home/gmc/.vscode \
  --include=gmc/1_personal \
  --exclude="gmc/Desktop" --exclude="gmc/Downloads" --exclude="gmc/.*" \
  /srv/backup/gmc /home/
