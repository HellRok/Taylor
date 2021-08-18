#!/usr/bin/env bash
set -euo pipefail

rake transpile
cp -v game.h ../taylor/include/
pushd ../taylor

EXPORT=1 rake linux:release:build
strip ./dist/linux/release/taylor

EXPORT=1 rake windows:release:build
x86_64-w64-mingw32-strip ./dist/windows/release/taylor.exe

EXPORT=1 rake osx:release:build
x86_64-apple-darwin19-strip ./dist/osx/release/taylor

popd

rake rename compress
