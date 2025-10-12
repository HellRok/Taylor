#!/usr/bin/env bash
set -euo pipefail

echo $GITHUB_AUTH_TOKEN | gh auth login --with-token

BUILD_PATH=$(pwd)
TEMP_DIR=$(mktemp --dir /tmp/buildkite/taylor.XXXXXXXXXXXX)

cp -r cli-tool "${TEMP_DIR}"
pushd "${TEMP_DIR}/cli-tool"
taylor ./cli.rb export
popd

gh release create \
  --notes-file release-body.md \
  --title "Release $BUILDKITE_BRANCH" \
  $BUILDKITE_BRANCH "${TEMP_DIR}/cli-tool/exports/*.zip"
