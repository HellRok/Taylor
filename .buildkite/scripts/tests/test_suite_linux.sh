#!/usr/bin/env bash

set -euxo pipefail

gem install bundler
bundle install

rm -rf /tmp/buildkite/taylor-test-suite/linux/
mkdir -p /tmp/buildkite/taylor-test-suite/linux/
buildkite-agent artifact download taylor-test-suite-linux-v0.0.1.zip /tmp/buildkite/taylor-test-suite/linux/
cd /tmp/buildkite/taylor-test-suite/linux/
unzip taylor-test-suite-linux-v0.0.1.zip
./taylor-test-suite
