#!/usr/bin/env bash
set -euo pipefail

pushd ./cli-tool
mkdir -p exports

# I would normally use a .template file by default here but this is useful for
# actually running this tool while developing and I didn't want to have to
# manage it twice, so let's just move before we envsubst
mv ./taylor-config.json ./taylor-config.json.template
envsubst < ./taylor-config.json.template > ./taylor-config.json

taylor export

popd
