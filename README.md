# noctalia-plugin-template

Template for a single-plugin Noctalia source: manifest, entry script,
translations, README, thumbnail, catalog, lint and release tooling.

## Layout

    catalog.toml            source index, [[plugin]] mirrors plugin.toml, release rows appended by release.sh
    example/                the plugin, directory name equals the id after the slash
      plugin.toml
      hello.luau
      README.md             plugin page, structure checked by the upstream validator
      thumbnail.webp        960x540, under 512 KB
      translations/en.json  every label_key and description_key in the manifest
    noctalia.d.luau         plugin API definitions for luau-lsp, copied from official-plugins
    flake.nix               dev shell with every tool the hooks call
    upstream.rev            pinned official-plugins commit for the validator and the copied editor files
    prek.toml               hooks: stylua, luau-lsp analyze, upstream validator, shellcheck, nixfmt, zizmor
    release.sh              cz bump, catalog row, tag, push

## New plugin from this template

1. Rename `example/` and replace `tanren/example`, `Example`, `example` in
   `example/plugin.toml`, `example/README.md`, `catalog.toml`, `cz.toml`,
   `release.sh` (`plugin=`).
2. Pick tags from the allowed list in the community-plugins README, set
   `plugin_api` to the current level from the manifest docs.
3. Replace `thumbnail.webp`:

       magick shot.png -resize 960x540^ -gravity center -extent 960x540 example/thumbnail.webp

   or use <https://assets.noctalia.dev/plugins/thumbnail-generator.html>.

## Upstream files

`upstream.rev` pins one official-plugins commit. `validate.sh` fetches the
manifest validator from it, and `noctalia.d.luau`, `.luaurc`,
`.vscode/settings.json` are copies from it. `sync-upstream.sh` moves the pin
to `main` and refreshes the copies; the `update-upstream` workflow runs it
weekly and opens a PR so CI shows whether the plugin still lints against the
new API. Set an `UPSTREAM_TOKEN` PAT secret if you want CI to run on those
PRs; the default token cannot trigger workflows.

## Develop

    noctalia msg plugins source add dev path "$PWD"
    noctalia msg plugins enable tanren/example

`.luau` edits hot-reload; manifest edits need a config reload. Every entry
file starts with `--!nonstrict`, matching `.luaurc`.

    nix develop -c prek run --all-files

## Release

Merge to master, then run the release workflow (or `nix develop -c
./release.sh` locally). It bumps `version` in `plugin.toml` from conventional
commits, tags `vX.Y.Z`, prepends a `[[plugin.release]]` row to
`catalog.toml`, and pushes. Keep the `[[plugin]]` block in `catalog.toml` in
sync with `plugin.toml` by hand for fields other than `version`.

## Install

    noctalia msg plugins source add example git https://github.com/tanrendev/example
    noctalia msg plugins enable tanren/example
