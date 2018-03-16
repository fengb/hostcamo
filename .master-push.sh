#!/bin/bash

set -euo pipefail

COMMIT_MESSAGE="[CI][${CI_PIPELINE_SOURCE}] ${CI_COMMIT_SHA:0:8}"
SECURE_URL="${CI_REPOSITORY_URL/\/\/*@///oauth:$ACCESS_TOKEN@}"

mv hosts hosts.new
git checkout --quiet master
mv hosts.new hosts
if git diff --quiet --exit-code; then
  exit
fi

git config user.name "CI"
git config user.email "ci@example.com"
git commit hosts --quiet --message="$COMMIT_MESSAGE"
git push --quiet "$SECURE_URL" master
