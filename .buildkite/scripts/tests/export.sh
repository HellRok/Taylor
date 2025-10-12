#!/usr/bin/env bash
set -euxo pipefail

BUILD_PATH=$(pwd)
TEMP_DIR=$(mktemp --dir /tmp/buildkite/taylor.XXXXXXXXXXXX)

cp -r test "${TEMP_DIR}"
pushd "${TEMP_DIR}/test"
taylor $BUILD_PATH/cli-tool/cli.rb export
pushd exports

buildkite-agent artifact upload "*.zip"

popd
popd

rm -rf "${TEMP_DIR}"
