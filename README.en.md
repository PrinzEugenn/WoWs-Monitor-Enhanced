[简体中文](README.md) | [English](README.en.md)

# WoWs Monitor Enhanced

An **unofficial enhancement patch** for the Windows edition of WoWs Monitor 1.3.4. The original application was created by stewie. This project is not affiliated with or endorsed by its author or Wargaming: [WoWs Monitor](https://wows-monitor.com/) · [Official downloads](https://wows-monitor.com/downloads).

This repository does not include the original installer or provide its backend service. Install the original application separately; the enhancement continues to depend on its data sources and operation.

## Features

- PR palettes, per-tier colors, a high-contrast slider, and an optional pure-black background.
- Player tiers based on account and current-ship win rates, ship-type icons, team comparisons, rosters, and copy buttons.
- A wide-screen three-column layout and simulated match for previewing the interface without entering a game.
- Simplified Chinese and English for enhancement features and common match-screen labels. Other screens supplied by the original application may remain in English.

The default tier score weights account win rate at least 80% and current-ship win rate at most 20%. Ship weight decreases below 100 ship battles; accounts with fewer than 100 battles or missing data are marked Unknown. This is **a win-rate estimate, not a combined PR, damage, or multi-metric rating**. Tier thresholds can be changed. Unknown players are excluded from tier statistics and copied rosters.

Ship type is read from application data where available, then looked up in a bundled snapshot. Unmatched ships show `?`; the snapshot may lag behind game updates. See [resource notices](NOTICE.md).

## Install and restore

1. Install [WoWs Monitor 1.3.4](https://wows-monitor.com/downloads) and Node.js 18 or newer.
2. **Exit WoWs Monitor completely, including its system tray process.** Download this repository and open PowerShell in its directory.
3. The examples use the default installation path; replace it if necessary. Check compatibility first:

   ```powershell
   node .\scripts\patch.js check "$env:LOCALAPPDATA\Programs\wows-monitor"
   ```

4. Install after the check succeeds:

   ```powershell
   node .\scripts\patch.js install "$env:LOCALAPPDATA\Programs\wows-monitor"
   ```

5. Start WoWs Monitor. Move the pointer to the bottom-right gear to open Settings; choose your language under Language. A simulated match is available under Debug.

Before installation, the patch checks the original version and key files' SHA-256 hashes, then backs up `resources/app.asar` as `app.asar.wows-enhanced.backup` in the same directory. An existing different backup is not overwritten. The patch modifies `app.asar` inside the installation directory; use a suitably privileged PowerShell if the directory requires administrator access.

To restore the original, exit the application completely and run:

```powershell
node .\scripts\patch.js restore "$env:LOCALAPPDATA\Programs\wows-monitor"
```

Restore verifies the backup and refuses to overwrite an application without the enhancement marker. It retains the backup. Enhancement settings remain in the application's local storage and are not automatically deleted on restore.

**Version support:** only the original 1.3.4 files matching the expected hashes are supported. Original updates or other patches can change those files; do not force installation after a failed check. An original auto-update can overwrite the enhancement; restore first and recheck compatibility before updating. A manually modified installation cannot be used as patch input until restored or reinstalled from the supported original.

## Verification and development

Supply your own supported original `app.asar`; do not commit it to this repository:

```powershell
node .\tests\archive.test.js "C:\path\to\original\app.asar"
```

The test exercises packaging, backup, restore, and tamper detection in a temporary directory. The interface and language switching were also checked in an isolated simulated match; not all real match data, game versions, or display layouts have been verified.

Run the core logic tests without the original application:

```powershell
node .\tests\core.test.js
```

## License and attribution

The original WoWs Monitor application, ship-type icons, and third-party data belong to their respective rights holders. Original project code and documentation may be used locally but may not be redistributed without permission; see the [project license](LICENSE.md). The original application and third-party resources have separate terms; see [NOTICE.md](NOTICE.md). Do not present this project as an official release.
