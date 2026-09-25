#!/usr/bin/env bash
set -euo pipefail

# Resolve Dart dependencies from pub.dev (same as conda-forge's build).
dart pub get
# Generate the protobuf sources (requires buf from the host environment).
dart run grinder protobuf
# Compile the sass CLI to a self-contained AOT executable.
dart compile exe --define="version=${PKG_VERSION}" bin/sass.dart -o "${PREFIX}/bin/sass"
