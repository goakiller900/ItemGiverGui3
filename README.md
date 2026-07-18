# Item Giver Gui 3

Unofficial community-maintained continuation of **Item Giver Gui** for **Factorio 2.1**.

Item Giver Gui adds a compact in-game window for finding items and giving them to, or removing them from, the current player inventory. The current continuation supports item quality selection, an optional beta search mode for translated item names, and a multilingual interface.

## Features

- Open or close the GUI with **Shift + Enter**.
- Search item prototype names with autocomplete suggestions.
- Optionally enable **Expanded item search (Beta)** to also search translated item names.
- Give a selected quantity of an item to the player.
- Remove a selected quantity of an item.
- Filter by common item types.
- Optionally show hidden prototypes.
- Select the quality of inserted items.
- Multilingual GUI, settings and player-facing messages.

The shortcut can be changed in **Settings → Controls → Mods → Toggle Giver Gui**.

## Localisation

Version `3.0.2` adds interface localisation for 20 high-reach languages supported by Factorio:

- English
- Simplified Chinese
- Spanish
- French
- Arabic
- Brazilian Portuguese
- Russian
- Indonesian
- German
- Japanese
- Vietnamese
- Turkish
- Korean
- Persian
- Italian
- Thai
- Polish
- Ukrainian
- Dutch
- Traditional Chinese

The non-English translations were AI-assisted and then spot-checked in-game before release. Native-speaker corrections and improvements are welcome through the project issue tracker.

The GUI labels, buttons, item categories, validation messages, success messages, beta setting and testing tooltips are localised. The quality selector also uses Factorio's own translated quality names.

Item names shown by the expanded-search beta continue to use Factorio's own localisation system and the localisation supplied by other installed mods.

## Expanded item search (Beta)

Version `3.0.1` introduced an optional expanded search mode for community testing. It is **disabled by default**, so the normal prototype-name search remains the standard behavior unless a player explicitly enables the beta.

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

1. Download the current `ItemGiverGui3_<version>.zip` from the GitHub Releases page or the Factorio Mod Portal.
2. Place the ZIP file in your Factorio `mods` directory.
3. Do not extract the ZIP.
4. Enable **Item Giver Gui 3** in Factorio's Mods menu.

For version `3.0.2`, the archive is:

```text
ItemGiverGui3_3.0.2.zip
```

and contains the required top-level directory:

```text
ItemGiverGui3_3.0.2/
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

The original version introduced the GUI, item-image suggestions, item removal, inventory/filter/sort controls and the default **Shift + Enter** shortcut.

### 2. Item Giver Gui (Fix) — Factorio 0.17 through 1.1

- **Maintainer:** [krangpow](https://mods.factorio.com/user/krangpow)
- **Factorio Mod Portal:** [ItemGiverGuiFix](https://mods.factorio.com/mod/ItemGiverGuiFix)
- **Releases:** `0.0.9` through `0.0.13`
- **Supported Factorio versions:** `0.17` through `1.1`
- **License:** MIT

This continuation updated and fixed the original mod for newer Factorio versions while explicitly preserving credit to coltonj96.

### 3. Item Giver Gui 2.0 — Factorio 2.0 / Space Age

- **Portal owner and publisher:** [gslandtreter](https://mods.factorio.com/user/gslandtreter)
- **Factorio Mod Portal:** [ItemGiverGui2](https://mods.factorio.com/mod/ItemGiverGui2)
- **Releases:** `2.0.0` through `2.0.2`
- **Supported Factorio version:** `2.0`
- **License:** MIT

The `2.0.x` continuation updated the mod for Factorio 2.0 / Space Age and added the quality selector in version `2.0.2`. The distributed metadata also lists **0xDEADC0DE**, so that credit is preserved as well.

### 4. Item Giver Gui 3 — Factorio 2.1

- **Current maintainer:** [goakiller900](https://github.com/goakiller900)
- **Source:** [goakiller900/ItemGiverGui3](https://github.com/goakiller900/ItemGiverGui3)

Item Giver Gui 3 updates the continuation for Factorio 2.1, corrects the Shift + Enter input declaration for the current API, preserves the original concept, interface, license and prior contributor credits, and continues development with optional expanded search and interface localisation.

### Other historical source

A separate public Factorio 0.17 source update also exists at [DarkScorpion/Item-giver-gui-factorio](https://github.com/DarkScorpion/Item-giver-gui-factorio). It retains coltonj96 as the original author. It is documented here as useful historical source material, but it is not presented as the confirmed direct predecessor of the current continuation.

This project is not an official release by the original author. If an earlier maintainer returns and wishes to resume maintenance, attribution, archival, redirection or transfer can be discussed through the repository issues.

## Automatic release packaging

The repository includes an automatic GitHub Actions release workflow.

- Pull requests and testing workflows validate the mod and build a correctly structured ZIP.
- Every push to `main` reads the mod name and version directly from `info.json`.
- The builder creates the required top-level folder automatically.
- When the version has not been released before, the workflow creates the matching Git tag and GitHub Release automatically.
- The ready-to-use ZIP and its SHA-256 checksum are published directly as downloadable files.
- Existing releases are treated as immutable. Increase the version in `info.json` before publishing changed mod contents under a new release.

The ZIP contains the mod files, including the localisation folders, while repository-only files such as `.git`, `.github`, `scripts` and `dist` are excluded automatically.

You can build the same archive locally with:

```bash
python scripts/build_release.py
```

The output is written to `dist/`.

## Automatic Factorio Mod Portal publishing

The release workflow is prepared to publish new versions directly to the Factorio Mod Portal.

Automatic portal publishing is restricted to the `main` branch. Development and testing branches only build and validate the mod and never publish a portal release.

The repository secret must be named exactly:

```text
FACTORIO_API_KEY
```

The Factorio API key requires permission to upload mods.

After the secret is configured:

- Every successful push to `main` builds the ZIP and creates or reuses the matching immutable GitHub Release.
- The same release ZIP is uploaded automatically to the Factorio Mod Portal when that version is not already present.
- Existing portal versions are detected and skipped safely rather than uploaded again.
- The workflow can also be started manually from **Actions → Build and release Factorio mod → Run workflow**.
- The API key is read only from GitHub Secrets and is never stored in the repository or printed in workflow logs.

## License

The original project was released under the MIT License. The original copyright and permission notice are retained in [LICENSE](LICENSE), as required by that license.
