#!/usr/bin/env bash

set -euxo pipefail

gem install bundler
bundle install

mkdir -p ./tmp
buildkite-agent artifact download taylor-test-suite-windows-v0.0.1.zip ./tmp
pushd ./tmp
unzip taylor-test-suite-windows-v0.0.1.zip
wine taylor-test-suite.exe
