#!/bin/sh

set -eu
set -f # disable globbing
export IFS=' '

echo "Uploading paths" $OUT_PATHS
exec nix copy --to "s3://example-nix-cache" $OUT_PATHS

