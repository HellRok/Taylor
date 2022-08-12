#!/usr/bin/env bash
set -euo pipefail

# Build the compilation images
bundle exec rake docker:build:all

# Build the export images
pushd scripts/export
bundle exec rake docker:build:all

popd
