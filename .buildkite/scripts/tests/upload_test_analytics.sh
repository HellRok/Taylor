#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${2+x}" ]]; then
  echo "I'm guessing you've hit \"Retry\" since I don't have the test analytics key!"
  exit 0
fi

FILE=$1
TEST_ANALYTICS_KEY=$2

if [[ -f $FILE ]]; then
  echo "Analytics file found, upload '$FILE'"
  curl \
    -X POST \
    -H "Authorization: Token token=\"$TEST_ANALYTICS_KEY\"" \
    -F "data=@$FILE" \
    -F "format=json" \
    -F "run_env[CI]=buildkite" \
    -F "run_env[key]=$BUILDKITE_BUILD_ID" \
    -F "run_env[url]=$BUILDKITE_BUILD_URL" \
    -F "run_env[branch]=$BUILDKITE_BRANCH" \
    -F "run_env[commit_sha]=$BUILDKITE_COMMIT" \
    -F "run_env[number]=$BUILDKITE_BUILD_NUMBER" \
    -F "run_env[job_id]=$BUILDKITE_JOB_ID" \
    -F "run_env[message]=$BUILDKITE_MESSAGE" \
    https://analytics-api.buildkite.com/v1/uploads
fi
