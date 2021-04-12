#!/usr/bin/env bash

set -euxo pipefail

cp -r ./include/* ./output/mruby/
cp -r ./build/host/lib/libmruby.a ./output/linux/
cp -r ./build/x86_64-w64-mingw32/lib/libmruby.a ./output/windows/
