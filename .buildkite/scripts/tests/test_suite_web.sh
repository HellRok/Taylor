#!/usr/bin/env bash

set -euxo pipefail

export BUILD_PATH=$(pwd)

gem install bundler
bundle install

mkdir -p ./tmp
buildkite-agent artifact download taylor-test-suite-web-v0.0.1.zip ./tmp
pushd ./tmp
unzip taylor-test-suite-web-v0.0.1.zip
$BUILD_PATH/.buildkite/scripts/tests/web_test.rb
