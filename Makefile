.PHONY: all test history

all: lint test

test:
	tests/.bash_unit tests/*

lint:
	shellcheck hostcamo tests/*

history:
	@: $${MESSAGE?}
	git checkout --quiet history
	git rm -r --ignore-unmatch --quiet .
	mv build/* .
	git add --all
	if ! git diff HEAD --quiet; then git commit --quiet --message="$(MESSAGE)"; fi
