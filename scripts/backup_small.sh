#!/usr/bin/env bash
#
# -------------------------------------------------------------------
# to_glaucus.sh 
#
# Sends a backup "lite" to an external drive for eventual transfer to
# a smaller laptop drive
# -------------------------------------------------------------------

SHARE=/mnt/backup
BUDIR=$SHARE/glaucus

rsync -avrt --delete --delete-excluded \
  --include=.config \
    --include=.config/joplin-desktop/plugins \
    --include=.config/joplin-desktop/settings.json \
    --exclude=".config/joplin-desktop/*" \
    --exclude=.config/Cider \
    --exclude=.config/Joplin \
    --exclude=.config/kwinrc \
    --exclude=.config/kactivitymanagerdrc \
    --exclude=.config/kglobalshortcutsrc \
    --exclude=.config/kxkbrc \
    --exclude=.config/kwinrulesrc \
  --include=".gitconfig*" \
  --include=.gnupg \
  --include=.local \
    --include=.local/share \
      --exclude=.local/share/Steam \
    --exclude=".local/share/baloo/*" \
    --exclude=".local/*" \
  --include=.ssh \
  --include=.vscode \
  --include=atlas \
    --include=atlas/**/.* \
  --include=calendar \
    --include=calendar/**/.* \
  --include=cards \
    --include=cards/**/.* \
  --include=extra \
    --include=extra/**/.* \
  --include=sources \
      --include=arts/**/.* --include=brain/**/.* \
      --include=cooking/**/.* --include=language/**/.* \
      --include=leadership/**/.* --include=photos \
      --include=projectmanagement/**/.* --include=sounds/**/.* \
      
      --include=tech/**/.* \
      --include=zaneyos/**/.* \
      --exclude=iCloud \
      --exclude=iso \
      --exclude=roms \
      --exclude=videos \
  --include=spaces \/**/.* \
    --include=spaces /**/.* \/**/.* \
    --exclude=sport \
  --exclude=archive \/**/.* \
  --exclude=Desktop \/**/.* \
  --exclude=Downloads \/**/.* \
  --exclude=tmp \/**/.* \
  --exclude=".*" \/**/.* \
  $HOME/ $BUDIR
