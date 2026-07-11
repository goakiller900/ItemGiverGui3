# Item Giver Gui 3

Unofficial community-maintained continuation of **Item Giver Gui** for **Factorio 2.1**.

Item Giver Gui adds a compact in-game window for finding items by prototype name and giving them to, or removing them from, the current player inventory. The current continuation also supports item quality selection.

## Features

- Open or close the GUI with **Shift + Enter**.
- Search item prototype names with autocomplete suggestions.
- Give a selected quantity of an item to the player.
- Remove a selected quantity of an item from the player.
- Filter by common item types.
- Optionally show hidden prototypes.
- Select the quality of inserted items.

The shortcut can be changed in **Settings → Controls → Mods → Toggle Giver Gui**.

## Installation

1. Download `ItemGiverGui3_3.0.0.zip` from the GitHub Releases page or the Factorio Mod Portal.
2. Place the ZIP file in your Factorio `mods` directory.
3. Do not extract the ZIP.
4. Enable **Item Giver Gui 3** in Factorio's Mods menu.

The release archive contains the required top-level directory:

```text
ItemGiverGui3_3.0.0/
```

## Project history and credits

This continuation is built on work maintained by several people over the lifetime of the mod. Their credits are deliberately preserved.

### Original: ItemGiverGui

- **Original author:** [coltonj96](https://github.com/coltonj96)
- **Original source:** [coltonj96/ItemGiverGui](https://github.com/coltonj96/ItemGiverGui)
- **Known original releases:** `0.0.1` through `0.0.8`
- **License:** MIT, copyright © 2017 coltonj96

The original repository's README only contained the project title, so the functional description in this README is based on the original source and `info.json` metadata.

### Factorio 0.17 community update

- **Updater:** [DarkScorpion](https://github.com/DarkScorpion)
- **Source:** [DarkScorpion/Item-giver-gui-factorio](https://github.com/DarkScorpion/Item-giver-gui-factorio)

This was a manual community update of the original mod for Factorio 0.17. It retained coltonj96 as the original author.

### Continuation: ItemGiverGui2

The `ItemGiverGui2` version `2.0.2` source metadata credits:

- **coltonj96** — original creator
- **krangpow** — continuation author/maintainer
- **0xDEADC0DE** — continuation author/maintainer

Its included changelog records Factorio 2.0 / Space Age support in version `2.0.1` and the quality selector in version `2.0.2`. No public source repository or substantial README for this continuation was located during the July 2026 lineage review, so these credits are preserved directly from its distributed `info.json` metadata.

### Current continuation: ItemGiverGui3

- **Maintainer:** [goakiller900](https://github.com/goakiller900)
- **Source:** [goakiller900/ItemGiverGui3](https://github.com/goakiller900/ItemGiverGui3)

ItemGiverGui3 updates the continuation for Factorio 2.1 while preserving the original concept, interface and prior maintainer credits.

This project is not an official release by the original author. If an earlier maintainer returns and wishes to resume maintenance, attribution, archival, redirection or transfer can be discussed through the repository issues.

## Automatic release packaging

The repository includes a fully automated GitHub Actions release workflow.

- Every pull request and manual workflow run validates the mod and builds a correctly structured ZIP.
- Every push to `main` builds the ZIP from the `name` and `version` fields in `info.json`.
- When that version has not been released before, the workflow automatically creates the matching Git tag and GitHub Release.
- The exact ready-to-use ZIP and a SHA-256 checksum are attached to the release.
- If the version already belongs to an older commit, the workflow fails instead of silently replacing an existing release. Increase the version in `info.json` before publishing another release.

For version `3.0.0`, the generated file is:

```text
ItemGiverGui3_3.0.0.zip
```

You can also build the same archive locally:

```bash
python scripts/build_release.py
```

The output is written to `dist/`.

## License

The original project was released under the MIT License. The original copyright and license notice are retained in [LICENSE](LICENSE).
