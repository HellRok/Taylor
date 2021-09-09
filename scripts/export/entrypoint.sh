#!/usr/bin/env bash
set -euo pipefail

rake transpile
cp -v game.h ../taylor/include/
pushd ../taylor

EXPORT=1 rake linux:release:build
EXPORT=1 rake windows:release:build
EXPORT=1 rake osx:release:build
EXPORT=1 rake web:release:build

popd

rake rename compress
