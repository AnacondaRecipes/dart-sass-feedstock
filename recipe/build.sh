#!/usr/bin/env bash
set -euo pipefail

# All Dart dependencies ship in the recipe pub cache (pure Dart sources, so
# the same cache serves every platform); pub resolves offline, keeping the
# build free of pub.dev access.
export PUB_CACHE="${SRC_DIR}/pub-cache"
mkdir -p "${PUB_CACHE}"
tar xzf "${RECIPE_DIR}/dart-sass-pub-cache.tar.gz" -C "${PUB_CACHE}"
dart pub get --offline

# The embedded language spec ships as a git bundle pinned to the sass/sass
# commit the release was built against (spec EMBEDDED_PROTOCOL_VERSION 3.3.0);
# without it, grinder clones sass/sass main, which is unpinned and drifts past
# the tagged dart-sass release (this broke every 1.101.x build).
export UPDATE_SASS_PROTOCOL=false
git clone "${RECIPE_DIR}/sass-language-88142a47.bundle" build/language

# Generate the protobuf sources (requires buf from the host environment).
dart run grinder protobuf
# Compile the sass CLI to a self-contained AOT executable.
dart compile exe --define="version=${PKG_VERSION}" bin/sass.dart -o "${PREFIX}/bin/sass"
