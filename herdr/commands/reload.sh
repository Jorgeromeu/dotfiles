#!/usr/bin/env bash
# desc: reload the running herdr server's config
set -eu
command -v herdr >/dev/null || { echo "herdr is not installed" >&2; exit 1; }
herdr server reload-config
echo "reloaded herdr config"
