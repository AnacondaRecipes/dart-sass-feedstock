#!/usr/bin/env bash
set -eux

mkdir -p "${PREFIX}/bin"
mkdir -p "${PREFIX}/share/dart-sass"

# conda-build extracts the archive flat: `sass` wrapper + `src/` (dart runtime,
# sass.snapshot, LICENSE)
cp -R sass src "${PREFIX}/share/dart-sass/"
chmod +x "${PREFIX}/share/dart-sass/sass" "${PREFIX}/share/dart-sass/src/dart"

ln -sf ../share/dart-sass/sass "${PREFIX}/bin/sass"
