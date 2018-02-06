#!/bin/bash

set -euo pipefail

mv hosts hosts.new
git checkout --quiet master
mv hosts.new hosts
if git diff --quiet --exit-code; then
  exit
fi

git config user.name "CI"
git config user.email "ci@example.com"
git commit hosts --quiet --message="Autocommit - ${CI_COMMIT_SHA:0:8}"
git push --quiet "$(sed -e "s#//.*@#//oauth2:$ACCESS_TOKEN@#" <<<"$CI_REPOSITORY_URL")" master
