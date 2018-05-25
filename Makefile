.PHONY: tests ci-history

tests:
	tests/bash_unit tests/*.bash

ci-history:
	git checkout --quiet history
	git ls-files -z | xargs -0 -I {} git rm --quiet "{}"
	mv build/* .
	git add --all
	if ! git diff HEAD --quiet; then git commit --quiet --message="[CI:${CI_PIPELINE_SOURCE}] ${CI_COMMIT_SHA}"; fi
