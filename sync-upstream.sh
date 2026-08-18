#!/usr/bin/env bash
set -eu
cd "$(dirname "$0")"

repo=https://github.com/noctalia-dev/official-plugins
rev=$(git ls-remote "$repo" refs/heads/main | cut -f1)
raw="https://raw.githubusercontent.com/noctalia-dev/official-plugins/$rev"

echo "$rev" > upstream.rev
curl -fsSL -o noctalia.d.luau "$raw/noctalia.d.luau"
curl -fsSL -o .luaurc "$raw/.luaurc"
curl -fsSL -o .vscode/settings.json "$raw/.vscode/settings.json"
