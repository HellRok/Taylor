#!/usr/bin/env bash
set -euo pipefail

echo $DOCKER_PASSWORD | docker login --username $DOCKER_USER --password-stdin

docker image push hellrok/taylor:linux-latest
docker image push hellrok/taylor:linux-$BUILDKITE_BRANCH
docker image push hellrok/taylor:windows-latest
docker image push hellrok/taylor:windows-$BUILDKITE_BRANCH
docker image push hellrok/taylor:osx-latest
docker image push hellrok/taylor:osx-$BUILDKITE_BRANCH
docker image push hellrok/taylor:web-latest
docker image push hellrok/taylor:web-$BUILDKITE_BRANCH
