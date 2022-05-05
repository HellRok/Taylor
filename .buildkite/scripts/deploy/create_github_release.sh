#!/usr/bin/env bash
set -euo pipefail

echo $GITHUB_AUTH_TOKEN | gh auth login --with-token
cp -r cli-tool /tmp/buildkite/
pushd /tmp/buildkite/cli-tool
taylor ./cli.rb export
popd

gh release create \
  --notes-file release-body.md \
  --title "Release $BUILDKITE_BRANCH" \
  $BUILDKITE_BRANCH /tmp/buildkite/cli-tool/exports/*.zip
