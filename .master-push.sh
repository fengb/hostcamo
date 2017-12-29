#!/bin/bash

set -euo pipefail

mv hosts hosts.new
git checkout -q master
mv hosts.new hosts
if git diff --exit-code; then
  exit
fi

git config user.name "CI"
git config user.email "ci@example.com"
git commit hosts -q --message='Autocommit'
git push -q "$(sed -e "s#//.*@#//oauth2:$ACCESS_TOKEN@#" <<<"$CI_REPOSITORY_URL")" master
