#!/usr/bin/env bash

set -euxo pipefail

gem install bundler
bundle install

mkdir -p ./tmp
buildkite-agent artifact download taylor-test-suite-linux-v0.0.1.zip ./tmp
pushd ./tmp
cd /tmp/buildkite/taylor-test-suite/linux/
unzip taylor-test-suite-linux-v0.0.1.zip
./taylor-test-suite
