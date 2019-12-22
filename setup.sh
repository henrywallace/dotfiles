#!/bin/bash

D=$(realpath "$(dirname "$0")")
DOTDIR=".dotdir"

linkDir() {
  root=$1
  for fn in "$root"/{,.}*; do
    bn="$(basename "$fn")"
    if [ "$bn" = '.' ] || [ "$bn" = '..' ]; then
      continue
    fi
    if [ -d "$fn" ] && [ ! -f "$fn/$DOTDIR" ]; then
      linkDir "$fn"
    else
      src="$D/$fn"
      dst=$(echo "$fn" \
        | sed 's@^home@'"$HOME"'@' \
        | sed 's/^root/\//' \
      )
      # If the dst already links to our src, then we don't need to link again.
      if [ "$(realpath "$src")" = "$(realpath -m "$dst")" ]; then
        continue
      fi
      # Make the necessary directory, since linking will fail otherwise.
      dn="$(dirname "$dst")"
      if [ ! -d "$dn" ]; then
        mkdir -p "$dn"
      fi
      # If it's a dead link, then just replace it.
      if [ ! -e "$dst" ]; then
        ln -fsT "$src" "$dst"
      else
        ln -sT "$src" "$dst"
      fi
    fi
  done
}

linkDir home
