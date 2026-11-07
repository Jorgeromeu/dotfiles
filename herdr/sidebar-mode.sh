#!/usr/bin/env bash
# Flip the collapsed sidebar between "compact" (narrow status rail) and "hidden" (zero width), then reload.
cfg="$HOME/.config/herdr/config.toml"
if grep -q '^sidebar_collapsed_mode = "hidden"' "$cfg"; then new=compact; else new=hidden; fi
sed --follow-symlinks -i "s/^sidebar_collapsed_mode = .*/sidebar_collapsed_mode = \"$new\"/" "$cfg"
herdr server reload-config >/dev/null
