#!/usr/bin/env bash

set -euxo pipefail

export BUILD_PATH=$(pwd)

gem install bundler
bundle install

rm -rf /tmp/buildkite/taylor-test-suite/web/
mkdir -p /tmp/buildkite/taylor-test-suite/web/
buildkite-agent artifact download taylor-test-suite-web-v0.0.1.zip /tmp/buildkite/taylor-test-suite/web/
cd /tmp/buildkite/taylor-test-suite/web/
unzip taylor-test-suite-web-v0.0.1.zip
$BUILD_PATH/.buildkite/scripts/tests/web_test.rb
