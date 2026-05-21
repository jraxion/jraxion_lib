# jraxion_lib

FiveM compatibility library for Jraxion resources (fork of peuren_lib).

## Releases

Every push to `main` publishes a [GitHub Release](https://github.com/jraxion/jraxion_lib/releases) with a zip that extracts to a folder named **`jraxion_lib`** — ready to drag into your `resources` directory (no `jraxion_lib-main` suffix).

1. Open the latest release and download `jraxion_lib-vX.Y.Z.zip`.
2. Extract and move the `jraxion_lib` folder into `resources/`.
3. Add `ensure jraxion_lib` to `server.cfg`.

Bump the `version` in `fxmanifest.lua` when you want the release name to reflect a new version number.

## Documentation
You can find more information and the installation guide [here](https://peuren-development.gitbook.io/peuren/peuren_lib/installation).

## Auto-detection
Leaving a compatibility option in `shared/config.lua` set to `nil` now tells the library to automatically choose the matching adapter when one of the supported resources is already running on your server. The detected selection is cached in `Config.AutoDetected` for debugging when `Config.Debug` is enabled.

## Our Resources
Check out our resources [here](https://peuren.dev)
