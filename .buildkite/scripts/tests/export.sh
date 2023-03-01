#!/usr/bin/env bash
set -euxo pipefail

export BUILD_PATH=$(pwd)
rm -rf /tmp/buildkite/test
cp -r test /tmp/buildkite/
pushd /tmp/buildkite/test
taylor $BUILD_PATH/cli-tool/cli.rb export
pushd exports

buildkite-agent artifact upload "*.zip"

popd
popd
