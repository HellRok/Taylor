#!/usr/bin/env bash

set -euxo pipefail

gem install bundler
bundle install

rm -rf /tmp/buildkite/taylor-test-suite/windows/
mkdir -p /tmp/buildkite/taylor-test-suite/windows/
buildkite-agent artifact download taylor-test-suite-windows-v0.0.1.zip /tmp/buildkite/taylor-test-suite/windows/
cd /tmp/buildkite/taylor-test-suite/windows/
unzip taylor-test-suite-windows-v0.0.1.zip
wine taylor-test-suite.exe
