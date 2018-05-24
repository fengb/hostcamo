.PHONY: tests commit-master

tests:
	tests/bash_unit tests/*.bash

ci-master:
	git checkout --quiet master
	mv build/* .
	if ! git diff --quiet --exit-code; then git add --all && git commit --quiet --message="[CI][${CI_PIPELINE_SOURCE}] ${CI_COMMIT_SHA:0:8}"; fi
