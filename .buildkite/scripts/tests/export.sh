#!/usr/bin/env bash
set -euxo pipefail

pushd test
taylor ../cli-tool/cli.rb export
pushd exports

buildkite-agent artifact upload "*.zip"

popd
popd
