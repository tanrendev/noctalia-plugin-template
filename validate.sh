#!/usr/bin/env bash
set -eu
cd "$(dirname "$0")"

rev=$(cat upstream.rev)
url="https://raw.githubusercontent.com/noctalia-dev/official-plugins/$rev/.github/workflows/validate-plugins.py"
curl -fsSL -o .validate-plugins.py "$url"
python3 .validate-plugins.py --root .
