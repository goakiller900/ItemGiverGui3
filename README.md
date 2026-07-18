# Item Giver Gui 3

Unofficial community-maintained continuation of **Item Giver Gui** for **Factorio 2.1**.

Item Giver Gui adds a compact in-game window for finding items by prototype name and giving them to, or removing them from, the current player inventory. The current continuation also supports item quality selection and includes an optional beta search mode for translated item names.

## Features

- Open or close the GUI with **Shift + Enter**.
- Search item prototype names with autocomplete suggestions.
- Optionally enable **Expanded item search (Beta)** to also search translated item names.
- Give a selected quantity of an item to the player.
- Remove a selected quantity of an item.
- Filter by common item types.
- Optionally show hidden prototypes.
- Select the quality of inserted items.

The shortcut can be changed in **Settings → Controls → Mods → Toggle Giver Gui**.

## Expanded item search (Beta)

Version `3.0.1` includes an optional expanded search mode for community testing. It is **disabled by default**, so the normal prototype-name search remains the standard behavior unless a player explicitly enables the beta.

Enable it in:

**Settings → Mod settings → Per player → Expanded item search (Beta)**

When enabled, the search:

- Matches both internal prototype names and translated item names shown to the current player.
- Uses case-insensitive matching.
- Sorts matching results by translated item name when sorting is enabled and a translation is available.
- Shows the internal prototype name in item tooltips for testing and troubleshooting.

The setting is per-player and can be enabled or disabled while the game is running. When it is disabled, Item Giver Gui uses the original prototype-name search implementation unchanged and does not build the translated-name search cache.

This feature is currently provided as a beta so players can test it with different languages and mod combinations. Feedback and bug reports are welcome through the repository issues.

## Installation

1. Download `ItemGiverGui3_3.0.1.zip` from the GitHub Releases page or the Factorio Mod Portal.
2. Place the ZIP file in your Factorio `mods` directory.
3. Do not extract the ZIP.
4. Enable **Item Giver Gui 3** in Factorio's Mods menu.

The release archive contains the required top-level directory:

```text
ItemGiverGui3_3.0.1/
```

## Project history and credits

Item Giver Gui 3 exists because several community maintainers kept the original idea working across later Factorio releases. Their contributions and the original license are preserved here.

### 1. Item Giver Gui — original mod

- **Creator:** [coltonj96](https://github.com/coltonj96)
- **Factorio Mod Portal:** [ItemGiverGui](https://mods.factorio.com/mod/ItemGiverGui)
- **Source:** [coltonj96/ItemGiverGui](https://github.com/coltonj96/ItemGiverGui)
- **Releases:** `0.0.1` through `0.0.8`
- **Supported Factorio versions:** `0.14` through `0.16`
- **License:** MIT, copyright © 2017 coltonj96

The original version introduced the GUI, item-image suggestions, item removal, inventory/filter/sort controls and the default **Shift + Enter** shortcut. Its GitHub README only contained the project title, so this README preserves and summarizes the fuller description and changelog published on the Factorio Mod Portal.

### 2. Item Giver Gui (Fix) — Factorio 0.17 through 1.1

- **Maintainer:** [krangpow](https://mods.factorio.com/user/krangpow)
- **Factorio Mod Portal:** [ItemGiverGuiFix](https://mods.factorio.com/mod/ItemGiverGuiFix)
- **Releases:** `0.0.9` through `0.0.13`
- **Supported Factorio versions:** `0.17` through `1.1`
- **License:** MIT

krangpow described this continuation as a bug-fix release of coltonj96's original mod and explicitly gave the original author full credit. The continuation updated the mod for Factorio `0.17`, `0.18` and `1.1`, fixed an inventory issue and changed the custom-input consuming mode to `game-only`.

### 3. Item Giver Gui 2.0 — Factorio 2.0 / Space Age

- **Portal owner and publisher:** [gslandtreter](https://mods.factorio.com/user/gslandtreter)
- **Factorio Mod Portal:** [ItemGiverGui2](https://mods.factorio.com/mod/ItemGiverGui2)
- **Releases:** `2.0.0` through `2.0.2`
- **Supported Factorio version:** `2.0`
- **License:** MIT

The portal page credits **coltonj96** and **krangpow** for the earlier work. The distributed `ItemGiverGui2` version `2.0.2` metadata also lists **0xDEADC0DE**, so that credit is preserved as well.

The `2.0.x` continuation updated the mod for Factorio 2.0 / Space Age and added the quality selector in version `2.0.2`. No public source repository was linked from its portal page, so the available portal description, packaged metadata and included changelog are the sources used for this part of the lineage.

### 4. Item Giver Gui 3 — Factorio 2.1

- **Current maintainer:** [goakiller900](https://github.com/goakiller900)
- **Source:** [goakiller900/ItemGiverGui3](https://github.com/goakiller900/ItemGiverGui3)

Item Giver Gui 3 updates the continuation for Factorio 2.1, corrects the Shift + Enter input declaration for the current API, preserves the original concept, interface, license and prior contributor credits, and includes an optional beta expanded search mode for translated item names.

### Other historical source

A separate public Factorio 0.17 source update also exists at [DarkScorpion/Item-giver-gui-factorio](https://github.com/DarkScorpion/Item-giver-gui-factorio). It retains coltonj96 as the original author. It is documented here as useful historical source material, but it is not presented as the confirmed direct predecessor of the current continuation.

This project is not an official release by the original author. If an earlier maintainer returns and wishes to resume maintenance, attribution, archival, redirection or transfer can be discussed through the repository issues.

## Automatic release packaging

The repository includes a fully automatic GitHub Actions release workflow.

- Every pull request and manual workflow run validates the mod and builds a correctly structured ZIP.
- Every push to `main` reads the mod name and version directly from `info.json`.
- The builder creates the required top-level folder automatically.
- When the version has not been released before, the workflow creates the matching Git tag and GitHub Release automatically.
- The ready-to-use ZIP and its SHA-256 checksum are attached to the release.
- Existing releases are treated as immutable. Increase the version in `info.json` before publishing changed mod contents under a new release.

For version `3.0.1`, the generated file is:

```text
ItemGiverGui3_3.0.1.zip
```

The ZIP contains:

```text
ItemGiverGui3_3.0.1/
├── info.json
├── settings.lua
├── control.lua
├── control_original.lua
├── localised_search.lua
├── data.lua
├── changelog.txt
├── locale/
├── prototypes/
├── README.md
└── LICENSE
```

Repository-only files such as `.git`, `.github`, `scripts` and `dist` are excluded automatically.

You can build the same archive locally with:

```bash
python scripts/build_release.py
```

The output is written to `dist/`.

## Automatic Factorio Mod Portal publishing

The same workflow can publish the generated ZIP directly to the Factorio Mod Portal.

The repository must contain a GitHub Actions repository secret named `FACTORIO_API_KEY`. The value must be a Factorio API key with permission to upload mods.

After the secret is configured:

- Every successful push to `main` uploads the current version when it is not already present on the portal.
- Existing portal versions are detected and skipped safely.
- The workflow can also be started manually from **Actions → Build and release Factorio mod → Run workflow**.
- Manual runs can publish the current version, including an existing GitHub release such as `3.0.1`.
- The API key is read only from GitHub Secrets and is never stored in the repository or printed in the workflow logs.

## License

The original project was released under the MIT License. The original copyright and permission notice are retained in [LICENSE](LICENSE), as required by that license.
