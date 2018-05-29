.PHONY: tests history

tests:
	tests/bash_unit tests/*.bash

history: MESSAGE ?= [dummy message]
history:
	git checkout --quiet history
	git rm -r --ignore-unmatch --quiet .
	mv build/* .
	git add --all
	if ! git diff HEAD --quiet; then git commit --quiet --message="$(MESSAGE)"; fi
