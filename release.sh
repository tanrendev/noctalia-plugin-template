#!/usr/bin/env bash
set -eu
cd "$(dirname "$0")"

plugin=example

cz bump --yes

version=$(sed -n 's/^version = "\(.*\)"/\1/p' "$plugin/plugin.toml")
rev=$(git rev-parse HEAD)
api=$(sed -n 's/^plugin_api = \([0-9]*\)/\1/p' "$plugin/plugin.toml")
sed -i "0,/^version = /s/^version = .*/version = \"$version\"/" catalog.toml
row=$(printf '[[plugin.release]]\nplugin_api = %s\nversion = "%s"\nrev = "%s"' "$api" "$version" "$rev")
awk -v row="$row" '
  !done && /^\[\[plugin\.release\]\]/ { print row; print ""; done = 1 }
  { print }
  END { if (!done) { print ""; print row } }
' catalog.toml > catalog.toml.new
mv catalog.toml.new catalog.toml
git commit -am "chore: add $version release row"

git push origin HEAD --tags
