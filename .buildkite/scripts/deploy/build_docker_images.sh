#!/usr/bin/env bash
set -euo pipefail

# Build the compilation images
bundle exec rake docker:build:all
