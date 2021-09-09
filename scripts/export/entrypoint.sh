#!/usr/bin/env bash
set -euxo pipefail

rake transpile build rename compress
