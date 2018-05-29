.PHONY: tests history

tests:
	tests/bash_unit tests/*.bash

history: MESSAGE ?= [dummy message]
history:
	git checkout --quiet history
	git ls-files -z | xargs -0 -I {} git rm --quiet "{}"
	mv build/* .
	git add --all
	if ! git diff HEAD --quiet; then git commit --quiet --message="$(MESSAGE)"; fi
