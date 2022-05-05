#!/usr/bin/env bash
set -euo pipefail

# Build all the base images
bundle exec rake docker:build:linux
bundle exec rake docker:build:windows
bundle exec rake docker:build:osx
bundle exec rake docker:build:web

# Build all the export images
pushd scripts/export
bundle exec rake docker:build:export
bundle exec rake docker:build:linux
bundle exec rake docker:build:windows
bundle exec rake docker:build:osx
bundle exec rake docker:build:web

popd
