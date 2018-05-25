.PHONY: tests commit-master

tests:
	tests/bash_unit tests/*.bash

ci-history:
	git checkout --quiet history
	mv build/* .
	if ! git diff --quiet --exit-code; then git add --all && git commit --quiet --message="[CI:${CI_PIPELINE_SOURCE}] ${CI_COMMIT_SHA}"; fi
